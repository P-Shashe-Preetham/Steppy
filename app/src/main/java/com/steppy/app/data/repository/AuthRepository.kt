package com.steppy.app.data.repository

import com.steppy.app.data.model.User
import kotlinx.coroutines.flow.Flow

interface AuthRepository {
    val currentUser: Flow<User?>
    suspend fun signUp(email: String, password: String, username: String): Result<Unit>
    suspend fun signIn(email: String, password: String): Result<Unit>
    suspend fun signOut()
    suspend fun resetPassword(email: String): Result<Unit>
    suspend fun updateUserStats(steps: Long, xp: Long, level: Int, newBadgeIds: List<String> = emptyList()): Result<Unit>
    suspend fun updateFcmToken(token: String): Result<Unit>
}
