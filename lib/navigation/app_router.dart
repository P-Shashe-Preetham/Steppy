import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/signup_screen.dart';
import '../ui/screens/home/home_screen.dart';
import '../ui/screens/search/search_screen.dart';
import '../ui/screens/analytics/analytics_screen.dart';
import '../ui/screens/social/leaderboard_screen.dart';
import '../ui/screens/profile/profile_screen.dart';
import '../ui/screens/challenge/challenge_list_screen.dart';
import '../ui/screens/challenge/create_challenge_screen.dart';
import '../ui/screens/challenge/challenge_detail_screen.dart';
import '../ui/screens/challenge/invite_friends_screen.dart';
import '../ui/screens/reward/reward_store_screen.dart';
import '../ui/widgets/steppy_bottom_nav.dart';

class AppRouter {
  static CustomTransitionPage _buildFadeTransitionPage({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }

  static CustomTransitionPage _buildSlideTransitionPage({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => _buildFadeTransitionPage(
          context: context,
          state: state,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) => _buildSlideTransitionPage(
          context: context,
          state: state,
          child: const SignupScreen(),
        ),
      ),
      GoRoute(
        path: '/challenges',
        pageBuilder: (context, state) => _buildSlideTransitionPage(
          context: context,
          state: state,
          child: const ChallengeListScreen(),
        ),
      ),
      GoRoute(
        path: '/challenges/create',
        pageBuilder: (context, state) => _buildSlideTransitionPage(
          context: context,
          state: state,
          child: const CreateChallengeScreen(),
        ),
      ),
      GoRoute(
        path: '/challenges/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return _buildSlideTransitionPage(
            context: context,
            state: state,
            child: ChallengeDetailScreen(challengeId: id),
          );
        },
      ),
      GoRoute(
        path: '/challenges/:id/invite',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return _buildSlideTransitionPage(
            context: context,
            state: state,
            child: InviteFriendsScreen(challengeId: id),
          );
        },
      ),
      GoRoute(
        path: '/reward-store',
        pageBuilder: (context, state) => _buildSlideTransitionPage(
          context: context,
          state: state,
          child: const RewardStoreScreen(),
        ),
      ),

      // Main Tab Shell with Floating SteppyBottomNav
      ShellRoute(
        builder: (context, state, child) {
          final selectedIndex = _calculateSelectedIndex(state.matchedLocation);
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(child: child),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SteppyBottomNav(
                    currentIndex: selectedIndex,
                    onTabSelected: (index) => _onItemTapped(index, context),
                  ),
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => _buildFadeTransitionPage(
              context: context,
              state: state,
              child: const HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/search',
            pageBuilder: (context, state) => _buildFadeTransitionPage(
              context: context,
              state: state,
              child: const SearchScreen(),
            ),
          ),
          GoRoute(
            path: '/statistics',
            pageBuilder: (context, state) => _buildFadeTransitionPage(
              context: context,
              state: state,
              child: const AnalyticsScreen(),
            ),
          ),
          GoRoute(
            path: '/leaderboard',
            pageBuilder: (context, state) => _buildFadeTransitionPage(
              context: context,
              state: state,
              child: const LeaderboardScreen(),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => _buildFadeTransitionPage(
              context: context,
              state: state,
              child: const ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
  );

  static int _calculateSelectedIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/statistics')) return 2;
    if (location.startsWith('/leaderboard')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  static void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/search');
        break;
      case 2:
        GoRouter.of(context).go('/statistics');
        break;
      case 3:
        GoRouter.of(context).go('/leaderboard');
        break;
      case 4:
        GoRouter.of(context).go('/profile');
        break;
    }
  }
}
