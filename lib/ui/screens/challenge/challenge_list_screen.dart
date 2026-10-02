import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../providers/challenge_provider.dart';

class ChallengeListScreen extends StatelessWidget {
  const ChallengeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final challengeProvider = context.watch<ChallengeProvider>();
    final challenges = challengeProvider.challenges;

    return Scaffold(
      appBar: AppBar(title: const Text('Challenges')),
      body: challenges.isEmpty
          ? const Center(child: Text('No active challenges. Tap + to create one!'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: challenges.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final challenge = challenges[index];
                return Card(
                  child: ListTile(
                    title: Text(challenge.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(challenge.description),
                        const SizedBox(height: 4),
                        Text('Goal: ${challenge.stepGoal} steps', style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                    onTap: () {
                      context.push('/challenges/${challenge.id}');
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/challenges/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
