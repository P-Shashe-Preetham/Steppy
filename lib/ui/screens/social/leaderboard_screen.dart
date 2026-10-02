import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/period_chip.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  static const List<Map<String, dynamic>> _users = [
    {'rank': 1, 'name': 'Sarah Walker', 'steps': '14,250', 'badge': '👑', 'xp': '1,425 XP', 'avatar': 'SW'},
    {'rank': 2, 'name': 'John Doe', 'steps': '12,850', 'badge': '🥈', 'xp': '1,285 XP', 'avatar': 'JD'},
    {'rank': 3, 'name': 'Alex Runner', 'steps': '11,400', 'badge': '🥉', 'xp': '1,140 XP', 'avatar': 'AR'},
    {'rank': 4, 'name': 'Emma Fit', 'steps': '9,800', 'xp': '980 XP', 'avatar': 'EF'},
    {'rank': 5, 'name': 'You (Champion)', 'steps': '8,500', 'xp': '850 XP', 'isCurrent': true, 'avatar': 'ME'},
    {'rank': 6, 'name': 'Michael B', 'steps': '7,200', 'xp': '720 XP', 'avatar': 'MB'},
    {'rank': 7, 'name': 'David K', 'steps': '6,100', 'xp': '610 XP', 'avatar': 'DK'},
  ];

  @override
  Widget build(BuildContext context) {
    final topThree = _users.sublist(0, 3);
    final restList = _users.sublist(3);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Leaderboard',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const PeriodChip(label: 'Today'),
                ],
              ),
              const SizedBox(height: 20),

              // Top 3 Podium
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 2nd Place (Rank 2)
                  Expanded(
                    child: _buildPodiumCard(topThree[1], height: 140, isFirst: false),
                  ),
                  const SizedBox(width: 10),
                  // 1st Place (Rank 1)
                  Expanded(
                    child: _buildPodiumCard(topThree[0], height: 165, isFirst: true),
                  ),
                  const SizedBox(width: 10),
                  // 3rd Place (Rank 3)
                  Expanded(
                    child: _buildPodiumCard(topThree[2], height: 130, isFirst: false),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Ranks 4+ List
              Text(
                'Rankings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: restList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final user = restList[index];
                  final isCurrent = user['isCurrent'] == true;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isCurrent ? AppColors.primaryContainer : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: isCurrent ? Border.all(color: AppColors.primary, width: 1.5) : null,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          offset: const Offset(4, 6),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 28,
                          child: Text(
                            '#${user['rank']}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textSubtle,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.fitnessBg,
                          child: Text(
                            user['avatar'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.fitnessPurple,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['name'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textDark,
                                ),
                              ),
                              Text(
                                user['xp'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              user['steps'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              ),
                            ),
                            const Text(
                              'steps',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSubtle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPodiumCard(Map<String, dynamic> user, {required double height, required bool isFirst}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      decoration: BoxDecoration(
        color: isFirst ? const Color(0xFFFFFDF5) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isFirst ? Border.all(color: AppColors.stepsGold, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(4, 6),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(user['badge'] as String, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 4),
          CircleAvatar(
            radius: isFirst ? 26 : 22,
            backgroundColor: isFirst ? AppColors.stepsGold : AppColors.primaryContainer,
            child: Text(
              user['avatar'] as String,
              style: TextStyle(
                fontSize: isFirst ? 16 : 14,
                fontWeight: FontWeight.w700,
                color: isFirst ? AppColors.textDark : AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user['name'] as String,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${user['steps']} steps',
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              user['xp'] as String,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
