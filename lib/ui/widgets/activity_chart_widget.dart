import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';

class ActivityChartWidget extends StatelessWidget {
  const ActivityChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 194,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hours column (5h down to 1h)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('5h', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                Text('4h', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                Text('3h', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                Text('2h', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                Text('1h', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Chart Graphic Overlay
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(
                  AppAssets.chartGrid,
                  fit: BoxFit.fill,
                ),
                SvgPicture.asset(
                  AppAssets.chartFill,
                  fit: BoxFit.fill,
                ),
                SvgPicture.asset(
                  AppAssets.chartLine,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
