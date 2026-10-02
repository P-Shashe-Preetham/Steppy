package com.steppy.app.domain.usecase

import com.steppy.app.data.model.Badge
import com.steppy.app.data.model.BadgeRequirementType
import com.steppy.app.data.model.User
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class GamificationUseCase @Inject constructor() {

    private val allBadges = listOf(
        Badge("10k_club", "10K Club", "Walk 10,000 steps in a single day", "", BadgeRequirementType.TOTAL_STEPS, 10000),
        Badge("streak_7", "7-Day Streak", "Maintain your daily goal for 7 days", "", BadgeRequirementType.STREAK_DAYS, 7),
        Badge("millionaire", "Step Millionaire", "Reach 1,000,000 total steps", "", BadgeRequirementType.TOTAL_STEPS, 1000000)
    )

    fun calculateXP(steps: Long): Long {
        return steps / 10 // 1 XP for every 10 steps
    }

    fun getLevel(xp: Long): Int {
        return (xp / 1000).toInt() + 1 // 1000 XP per level
    }

    fun getProgressToNextLevel(xp: Long): Float {
        val currentLevelXP = xp % 1000
        return currentLevelXP.toFloat() / 1000f
    }

    fun checkNewBadges(user: User, todaySteps: Long): List<String> {
        val newBadges = mutableListOf<String>()
        
        allBadges.forEach { badge ->
            if (badge.id !in user.earnedBadgeIds) {
                val met = when (badge.requirementType) {
                    BadgeRequirementType.TOTAL_STEPS -> user.totalSteps + todaySteps >= badge.requirementValue
                    BadgeRequirementType.STREAK_DAYS -> user.currentStreak >= badge.requirementValue
                    else -> false
                }
                if (met) newBadges.add(badge.id)
            }
        }
        
        return newBadges
    }
}
