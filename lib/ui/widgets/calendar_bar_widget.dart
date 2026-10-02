import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CalendarBarWidget extends StatefulWidget {
  final ValueChanged<int>? onDateSelected;

  const CalendarBarWidget({super.key, this.onDateSelected});

  @override
  State<CalendarBarWidget> createState() => _CalendarBarWidgetState();
}

class _CalendarBarWidgetState extends State<CalendarBarWidget> {
  int _selectedDate = 15;

  final List<String> _weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  final List<int> _dates = [13, 14, 15, 16, 17, 18, 19];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'June 2022',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: -24),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          color: AppColors.surfaceAlt,
          child: Column(
            children: [
              // Weekdays row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _weekdays
                    .map(
                      (day) => SizedBox(
                        width: 32,
                        child: Text(
                          day,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 12),
              // Dates row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _dates.map((date) {
                  final isSelected = date == _selectedDate;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedDate = date);
                      widget.onDateSelected?.call(date);
                    },
                    child: Container(
                      width: 32,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.navDark : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$date',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? AppColors.navActiveText : AppColors.textSubtle,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
