import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/challenge_provider.dart';

class ChallengeDetailScreen extends StatefulWidget {
  final String challengeId;

  const ChallengeDetailScreen({super.key, required this.challengeId});

  @override
  State<ChallengeDetailScreen> createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChallengeProvider>().listenToChallengeDetail(widget.challengeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final challengeProvider = context.watch<ChallengeProvider>();

    final challenge = challengeProvider.currentChallenge;
    final participants = challengeProvider.participants;
    final currentUserId = authProvider.user?.uid ?? '';

    final isParticipant = participants.any((p) => p.userId == currentUserId);
    final isCreator = challenge != null && challenge.creatorId == currentUserId;

    return Scaffold(
      appBar: AppBar(
        title: Text(challenge?.name ?? 'Challenge Detail'),
        actions: [
          if (isCreator)
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () => context.push('/challenges/${widget.challengeId}/invite'),
            ),
        ],
      ),
      body: challenge == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    challenge.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Goal: ${challenge.stepGoal} steps',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (!isParticipant) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final user = authProvider.user;
                          if (user != null) {
                            challengeProvider.joinChallenge(
                              challengeId: widget.challengeId,
                              userId: user.uid,
                              username: user.email?.split('@').first ?? 'User',
                              profileImageUrl: '',
                            );
                          }
                        },
                        child: const Text('Join Challenge'),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text(
                    'Leaderboard',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: participants.isEmpty
                        ? const Center(child: Text('No participants yet'))
                        : ListView.separated(
                            itemCount: participants.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final p = participants[index];
                              final isCurrentUser = p.userId == currentUserId;
                              return Card(
                                color: isCurrentUser
                                    ? Theme.of(context).colorScheme.primaryContainer
                                    : Theme.of(context).colorScheme.surfaceVariant,
                                child: ListTile(
                                  leading: Text(
                                    '#${index + 1}',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  title: Text(
                                    p.username,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('${p.steps} steps'),
                                  trailing: isCurrentUser
                                      ? Chip(
                                          label: const Text('You'),
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                          labelStyle: const TextStyle(color: Colors.white),
                                        )
                                      : null,
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
