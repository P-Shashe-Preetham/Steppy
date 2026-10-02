import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/user_provider.dart';
import '../../widgets/activity_chart_widget.dart';
import '../../widgets/gym_card.dart';
import '../../widgets/period_chip.dart';
import '../../widgets/steppy_icon_button.dart';
import '../../widgets/upcoming_workout_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: 110,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SteppyIconButton(
                    iconAsset: AppAssets.categoriesMenu,
                    tooltip: 'Categories',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Categories menu')),
                      );
                    },
                  ),
                  Row(
                    children: [
                      SteppyIconButton(
                        iconAsset: AppAssets.messages,
                        tooltip: 'Messages',
                        onTap: () {},
                      ),
                      const SizedBox(width: 14),
                      SteppyIconButton(
                        iconAsset: AppAssets.notifications,
                        tooltip: 'Notifications',
                        hasNotification: true,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Home',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),

              // Interactive Live Step Tracker Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Color(0xFF0056BA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.25),
                      offset: const Offset(0, 8),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today's Progress",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${userProvider.todaySteps}',
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' / ${userProvider.dailyGoal} steps',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white.withOpacity(0.85),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            userProvider.syncSteps(750);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Synced +750 steps! (+75 XP) 👟'),
                                duration: Duration(milliseconds: 1800),
                              ),
                            );
                          },
                          icon: const Text('👟'),
                          label: const Text('+750 Walk'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primary,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(48),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: userProvider.progressFraction,
                        minHeight: 8,
                        backgroundColor: Colors.white.withOpacity(0.25),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.stepsGold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${(userProvider.progressFraction * 100).toInt()}% of daily goal',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${userProvider.coins} Coins 🪙 · Level ${userProvider.level}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Upcoming Activities Section
              Text(
                'Upcoming',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 171,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  children: const [
                    UpcomingWorkoutCard(
                      title: 'Workout',
                      category: 'Fitness',
                      scheduledTime: 'Today at 2:45 PM',
                      location: 'Aleja Pokoju',
                      isWorkout: true,
                    ),
                    SizedBox(width: 16),
                    UpcomingWorkoutCard(
                      title: 'Push-ups',
                      category: 'Warm-up',
                      scheduledTime: 'Tomorrow at 10:00 AM',
                      isWorkout: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Gyms Near You Section
              Text(
                'Gyms near you',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.locationPinMd,
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Starowiślna 12',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSubtle,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(
                    child: SteppyGymCard(
                      name: 'GymFit',
                      hours: '10:00 AM – 11:00 PM',
                      distance: '250 meters',
                      rating: 5.0,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: SteppyGymCard(
                      name: 'Lotus',
                      hours: '24/7',
                      distance: '630 meters',
                      rating: 5.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Activities Timeline Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Activities',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const PeriodChip(label: 'Weekly'),
                ],
              ),
              const SizedBox(height: 16),
              const ActivityChartWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
