package com.steppy.app.navigation

sealed class Screen(val route: String) {
    object Login : Screen("login")
    object Signup : Screen("signup")
    object Home : Screen("home")
    object Challenges : Screen("challenges")
    object Leaderboard : Screen("leaderboard")
    object Friends : Screen("friends")
    object Profile : Screen("profile")
    object CreateChallenge : Screen("create_challenge")
    object ChallengeDetail : Screen("challenge_detail/{challengeId}") {
        fun createRoute(challengeId: String) = "challenge_detail/$challengeId"
    }
    object InviteFriends : Screen("invite_friends/{challengeId}") {
        fun createRoute(challengeId: String) = "invite_friends/$challengeId"
    }
    object RewardStore : Screen("reward_store")
    object Analytics : Screen("analytics")
}
