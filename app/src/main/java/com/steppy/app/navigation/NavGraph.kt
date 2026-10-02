package com.steppy.app.navigation

import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.hilt.lifecycle.viewmodel.compose.hiltViewModel
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.steppy.app.ui.screens.analytics.AnalyticsScreen
import com.steppy.app.ui.screens.auth.LoginScreen
import com.steppy.app.ui.screens.auth.SignupScreen
import com.steppy.app.ui.screens.challenge.ChallengeDetailScreen
import com.steppy.app.ui.screens.challenge.ChallengeListScreen
import com.steppy.app.ui.screens.challenge.CreateChallengeScreen
import com.steppy.app.ui.screens.challenge.InviteFriendsScreen
import com.steppy.app.ui.screens.home.HomeScreen
import com.steppy.app.ui.screens.profile.ProfileScreen
import com.steppy.app.ui.screens.reward.RewardStoreScreen
import com.steppy.app.ui.screens.social.FriendsScreen
import com.steppy.app.ui.screens.social.LeaderboardScreen
import com.steppy.app.viewmodel.auth.AuthViewModel

@Composable
fun NavGraph(
    navController: NavHostController,
    modifier: Modifier = Modifier,
    authViewModel: AuthViewModel = hiltViewModel(),
) {
    val currentUser by authViewModel.currentUser.collectAsState()
    val startDestination = if (currentUser == null) Screen.Login.route else Screen.Home.route

    NavHost(
        navController = navController,
        startDestination = startDestination,
        modifier = modifier
    ) {
        composable(Screen.Login.route) {
            LoginScreen(
                onNavigateToSignup = { navController.navigate(Screen.Signup.route) },
                onLoginSuccess = { navController.navigate(Screen.Home.route) {
                    popUpTo(Screen.Login.route) { inclusive = true }
                } }
            )
        }
        composable(Screen.Signup.route) {
            SignupScreen(
                onNavigateToLogin = { navController.popBackStack() },
                onSignupSuccess = { navController.navigate(Screen.Home.route) {
                    popUpTo(Screen.Signup.route) { inclusive = true }
                } }
            )
        }
        composable(Screen.Home.route) {
            HomeScreen(
                onNavigateToAnalytics = { navController.navigate(Screen.Analytics.route) }
            )
        }
        composable(Screen.Challenges.route) {
            ChallengeListScreen(
                onNavigateToCreate = { navController.navigate(Screen.CreateChallenge.route) },
                onNavigateToDetail = { id -> navController.navigate(Screen.ChallengeDetail.createRoute(id)) }
            )
        }
        composable(Screen.CreateChallenge.route) {
            CreateChallengeScreen(
                onChallengeCreated = { navController.popBackStack() },
                onBack = { navController.popBackStack() }
            )
        }
        composable(Screen.ChallengeDetail.route) {
            ChallengeDetailScreen(
                onBack = { navController.popBackStack() },
                onNavigateToInvite = { id -> navController.navigate(Screen.InviteFriends.createRoute(id)) }
            )
        }
        composable(Screen.InviteFriends.route) {
            InviteFriendsScreen(
                onBack = { navController.popBackStack() }
            )
        }
        composable(Screen.Leaderboard.route) {
            LeaderboardScreen()
        }
        composable(Screen.Profile.route) {
            ProfileScreen(
                onNavigateToRewards = { navController.navigate(Screen.RewardStore.route) }
            )
        }
        composable(Screen.Friends.route) {
            FriendsScreen()
        }
        composable(Screen.RewardStore.route) {
            RewardStoreScreen()
        }
        composable(Screen.Analytics.route) {
            AnalyticsScreen()
        }
    }
}
