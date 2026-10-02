package com.steppy.app.data.repository

import com.steppy.app.data.model.User
import kotlinx.coroutines.flow.Flow

interface FriendsRepository {
    fun getFriends(userId: String): Flow<List<User>>
    suspend fun searchUsers(query: String): Result<List<User>>
    suspend fun sendFriendRequest(fromUserId: String, toUserId: String): Result<Unit>
    suspend fun acceptFriendRequest(userId: String, friendId: String): Result<Unit>
}
