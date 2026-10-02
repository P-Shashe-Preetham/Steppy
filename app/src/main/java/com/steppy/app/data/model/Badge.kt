package com.steppy.app.data.model

data class Badge(
    val id: String = "",
    val name: String = "",
    val description: String = "",
    val iconUrl: String = "",
    val requirementType: BadgeRequirementType = BadgeRequirementType.TOTAL_STEPS,
    val requirementValue: Long = 0
)

enum class BadgeRequirementType {
    TOTAL_STEPS, DAILY_GOAL_REACHED, CHALLENGE_WON, STREAK_DAYS
}
