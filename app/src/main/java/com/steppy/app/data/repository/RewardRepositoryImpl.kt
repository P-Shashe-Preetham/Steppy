package com.steppy.app.data.repository

import com.steppy.app.data.model.Redemption
import com.steppy.app.data.model.Reward
import com.google.firebase.firestore.FirebaseFirestore
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.tasks.await
import javax.inject.Inject

class RewardRepositoryImpl @Inject constructor(
    private val firestore: FirebaseFirestore
) : RewardRepository {

    override fun getRewards(): Flow<List<Reward>> = callbackFlow {
        val subscription = firestore.collection("rewards")
            .addSnapshotListener { snapshot, error ->
                if (error != null) return@addSnapshotListener
                if (snapshot != null) {
                    trySend(snapshot.toObjects(Reward::class.java))
                }
            }
        awaitClose { subscription.remove() }
    }

    override suspend fun redeemReward(userId: String, reward: Reward): Result<Unit> {
        return try {
            firestore.runTransaction { transaction ->
                val userRef = firestore.collection("users").document(userId)
                val userSnapshot = transaction.get(userRef)
                val currentCoins = userSnapshot.getLong("coins") ?: 0L
                
                if (currentCoins < reward.cost) {
                    throw Exception("Not enough coins")
                }
                
                // Deduct coins
                transaction.update(userRef, "coins", currentCoins - reward.cost)
                
                // Record redemption
                val redemptionRef = firestore.collection("redemptions").document()
                val redemption = Redemption(
                    userId = userId,
                    rewardId = reward.id
                )
                transaction.set(redemptionRef, redemption)
            }.await()
            Result.success(Unit)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
}
