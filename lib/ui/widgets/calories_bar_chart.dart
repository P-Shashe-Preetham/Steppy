import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CaloriesBarChart extends StatelessWidget {
  const CaloriesBarChart({super.key});

  static const List<Map<String, dynamic>> _daysData = [
    {'day': 'Mon', 'height': 0.48, 'color': Color(0xFF80BBFF)},
    {'day': 'Tue', 'height': 0.72, 'color': Color(0xFF80BBFF)},
    {'day': 'Wed', 'height': 0.54, 'color': AppColors.primary},
    {'day': 'Thu', 'height': 0.96, 'color': AppColors.activityGreen},
    {'day': 'Fri', 'height': 0.38, 'color': AppColors.activityGreen},
    {'day': 'Sat', 'height': 0.60, 'color': AppColors.activityGreen},
    {'day': 'Sun', 'height': 0.82, 'color': Color(0xFF80BBFF)},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Bar tracks
        SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _daysData.map((d) {
              final double heightFraction = d['height'] as double;
              final Color barColor = d['color'] as Color;

              return Container(
                width: 24,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: heightFraction,
                  widthFactor: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        // Day labels row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _daysData.map((d) {
            return SizedBox(
              width: 24,
              child: Text(
                d['day'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
