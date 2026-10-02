import 'package:flutter/material.dart';

class PodiumWidget extends StatelessWidget {
  final Map<String, dynamic>? first;
  final Map<String, dynamic>? second;
  final Map<String, dynamic>? third;

  const PodiumWidget({
    super.key,
    this.first,
    this.second,
    this.third,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // 2nd Place
        if (second != null)
          _buildPodiumSpot(
            context: context,
            username: second!['username'] ?? 'User',
            steps: second!['steps'] ?? 0,
            rank: 2,
            height: 100,
            color: Colors.grey.shade400,
            badge: '🥈',
          ),
        const SizedBox(width: 12),
        // 1st Place
        if (first != null)
          _buildPodiumSpot(
            context: context,
            username: first!['username'] ?? 'User',
            steps: first!['steps'] ?? 0,
            rank: 1,
            height: 130,
            color: Colors.amber.shade600,
            badge: '👑',
          ),
        const SizedBox(width: 12),
        // 3rd Place
        if (third != null)
          _buildPodiumSpot(
            context: context,
            username: third!['username'] ?? 'User',
            steps: third!['steps'] ?? 0,
            rank: 3,
            height: 80,
            color: Colors.brown.shade400,
            badge: '🥉',
          ),
      ],
    );
  }

  Widget _buildPodiumSpot({
    required BuildContext context,
    required String username,
    required int steps,
    required int rank,
    required double height,
    required Color color,
    required String badge,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(badge, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 2),
        CircleAvatar(
          radius: rank == 1 ? 28 : 22,
          backgroundColor: color,
          child: Text(
            username.isNotEmpty ? username[0].toUpperCase() : '?',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          username,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '$steps',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: color.withOpacity(0.85),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Center(
            child: Text(
              '#$rank',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
