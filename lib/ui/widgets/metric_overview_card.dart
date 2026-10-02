import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';

class MetricOverviewGrid extends StatelessWidget {
  const MetricOverviewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildCard(
            bgAsset: AppAssets.overviewCaloriesBg,
            iconAsset: AppAssets.overviewCaloriesIcon,
            value: '3.950',
            label: 'Cal Burnt',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildCard(
            bgAsset: AppAssets.overviewTimeBg,
            iconAsset: AppAssets.overviewTimeIcon,
            value: '3h 14m',
            label: 'Total Time',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildCard(
            bgAsset: AppAssets.overviewExercisesBg,
            value: '15',
            label: 'Exercises',
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String bgAsset,
    String? iconAsset,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(4, 6),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(bgAsset, width: 32, height: 32),
                if (iconAsset != null)
                  SvgPicture.asset(iconAsset, width: 16, height: 16),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textMuted,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
