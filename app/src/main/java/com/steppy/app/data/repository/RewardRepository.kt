package com.steppy.app.data.repository

import com.steppy.app.data.model.Reward
import kotlinx.coroutines.flow.Flow

interface RewardRepository {
    fun getRewards(): Flow<List<Reward>>
    suspend fun redeemReward(userId: String, reward: Reward): Result<Unit>
}
