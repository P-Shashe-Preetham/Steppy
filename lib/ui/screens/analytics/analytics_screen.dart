import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/calendar_bar_widget.dart';
import '../../widgets/calories_bar_chart.dart';
import '../../widgets/concentric_progress_rings.dart';
import '../../widgets/metric_overview_card.dart';
import '../../widgets/period_chip.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 20,
            bottom: 110,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statistics',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),

              // Calendar Weekdays + Dates bar
              const CalendarBarWidget(),
              const SizedBox(height: 32),

              // Overview Grid (3 columns)
              Text(
                'Overview',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const MetricOverviewGrid(),
              const SizedBox(height: 32),

              // Daily Progress Rings
              Text(
                'Daily progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const ConcentricProgressRings(),
              const SizedBox(height: 32),

              // Weekly Calories Chart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Calories',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const PeriodChip(label: 'Weekly'),
                ],
              ),
              const SizedBox(height: 20),
              const CaloriesBarChart(),
            ],
          ),
        ),
      ),
    );
  }
}
