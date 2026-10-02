import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/gym_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  static const List<Map<String, dynamic>> _gyms = [
    {'name': 'GymFit', 'hours': '10:00 AM – 11:00 PM', 'distance': '250 meters', 'rating': 5.0},
    {'name': 'Lotus', 'hours': '24/7', 'distance': '630 meters', 'rating': 5.0},
    {'name': 'PowerGym Kraków', 'hours': '6:00 AM – Midnight', 'distance': '1.2 km', 'rating': 4.9},
    {'name': 'CrossFit Central', 'hours': '7:00 AM – 10:00 PM', 'distance': '1.8 km', 'rating': 4.8},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _gyms.where((g) {
      final name = (g['name'] as String).toLowerCase();
      final dist = (g['distance'] as String).toLowerCase();
      return name.contains(_query.toLowerCase()) || dist.contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore & Search',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),

              // Search Bar
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.navSearch,
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textMuted,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) => setState(() => _query = val),
                        decoration: const InputDecoration(
                          hintText: 'Search gyms, workouts, locations...',
                          hintStyle: TextStyle(
                            color: AppColors.textSubtle,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    if (_query.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                        child: const Icon(Icons.clear, size: 18, color: AppColors.textMuted),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Nearby Locations (${filtered.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              Expanded(
                child: ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return SteppyGymCard(
                      name: item['name'] as String,
                      hours: item['hours'] as String,
                      distance: item['distance'] as String,
                      rating: item['rating'] as double,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
