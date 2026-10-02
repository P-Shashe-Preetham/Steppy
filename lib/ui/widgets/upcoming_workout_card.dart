import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';

class UpcomingWorkoutCard extends StatelessWidget {
  final String title;
  final String category;
  final String scheduledTime;
  final String? location;
  final bool isWorkout;

  const UpcomingWorkoutCard({
    super.key,
    required this.title,
    required this.category,
    required this.scheduledTime,
    this.location,
    this.isWorkout = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 292,
      height: 171,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isWorkout ? AppColors.fitnessBg : AppColors.warmupBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          // Background Vector Artwork
          if (isWorkout) ...[
            Positioned(
              right: 18,
              top: 36,
              child: SvgPicture.asset(
                AppAssets.workoutRunner,
                width: 78,
                height: 78,
              ),
            ),
            Positioned(
              right: 12,
              bottom: 24,
              child: SvgPicture.asset(
                AppAssets.workoutTreadmill,
                width: 96,
                height: 48,
              ),
            ),
          ] else ...[
            Positioned(
              right: 24,
              bottom: 24,
              child: SvgPicture.asset(
                AppAssets.pushupsArt,
                width: 110,
                height: 70,
              ),
            ),
          ],

          // Card Copy (Title, Chip, Time)
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: Text(
                        category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                          color: isWorkout
                              ? AppColors.fitnessPurple
                              : AppColors.warmupOrange,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  scheduledTime,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                if (location != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppAssets.locationPinSm,
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
