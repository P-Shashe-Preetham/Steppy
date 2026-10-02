package com.steppy.app.data.model

import com.google.firebase.firestore.DocumentId

data class Reward(
    @DocumentId val id: String = "",
    val name: String = "",
    val description: String = "",
    val cost: Long = 0,
    val imageUrl: String = ""
)

data class Redemption(
    @DocumentId val id: String = "",
    val userId: String = "",
    val rewardId: String = "",
    val timestamp: java.util.Date = java.util.Date()
)
