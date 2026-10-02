import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';

class ConcentricProgressRings extends StatelessWidget {
  final String sleepValue;
  final String caloriesValue;
  final String stepsValue;

  const ConcentricProgressRings({
    super.key,
    this.sleepValue = '6h 5min/8h',
    this.caloriesValue = '1050/2000',
    this.stepsValue = '2015/6000',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Concentric rings
        SizedBox(
          width: 170,
          height: 170,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.progressRingSleep,
                width: 170,
                height: 170,
              ),
              SvgPicture.asset(
                AppAssets.progressRingCalories,
                width: 130,
                height: 130,
              ),
              SvgPicture.asset(
                AppAssets.progressRingSteps,
                width: 90,
                height: 90,
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        // Legend
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLegendRow(
                dotColor: AppColors.sleepBlue,
                label: 'Sleep',
                value: sleepValue,
              ),
              const SizedBox(height: 14),
              _buildLegendRow(
                dotColor: AppColors.caloriesCoral,
                label: 'Calories',
                value: caloriesValue,
              ),
              const SizedBox(height: 14),
              _buildLegendRow(
                dotColor: AppColors.stepsGold,
                label: 'Steps',
                value: stepsValue,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendRow({
    required Color dotColor,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
