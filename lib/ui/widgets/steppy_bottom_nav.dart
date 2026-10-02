import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';

class SteppyBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const SteppyBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 10),
            blurRadius: 28,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildItem(
            index: 0,
            label: 'Home',
            activeSvg: AppAssets.navHomeActive,
            inactiveSvg: AppAssets.navHomeInactive,
          ),
          _buildItem(
            index: 1,
            label: 'Search',
            activeSvg: AppAssets.navSearch,
            inactiveSvg: AppAssets.navSearch,
          ),
          _buildItem(
            index: 2,
            label: 'Statistics',
            activeSvg: AppAssets.navStatisticsActive,
            inactiveSvg: AppAssets.navStatisticsInactive,
          ),
          _buildLeaderboardItem(index: 3, label: 'Ranks'),
          _buildItem(
            index: 4,
            label: 'Profile',
            activeSvg: AppAssets.navProfile,
            inactiveSvg: AppAssets.navProfile,
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required int index,
    required String label,
    required String activeSvg,
    required String inactiveSvg,
  }) {
    final isSelected = currentIndex == index;

    if (isSelected) {
      return GestureDetector(
        onTap: () => onTabSelected(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.navDark,
            borderRadius: BorderRadius.circular(48),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                activeSvg,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.navActiveText,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.navActiveText,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return IconButton(
      onPressed: () => onTabSelected(index),
      icon: SvgPicture.asset(
        inactiveSvg,
        width: 22,
        height: 22,
      ),
    );
  }

  Widget _buildLeaderboardItem({
    required int index,
    required String label,
  }) {
    final isSelected = currentIndex == index;

    if (isSelected) {
      return GestureDetector(
        onTap: () => onTabSelected(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.navDark,
            borderRadius: BorderRadius.circular(48),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.leaderboard,
                size: 20,
                color: AppColors.navActiveText,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.navActiveText,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return IconButton(
      onPressed: () => onTabSelected(index),
      icon: const Icon(
        Icons.leaderboard_outlined,
        size: 22,
        color: AppColors.textMuted,
      ),
    );
  }
}
