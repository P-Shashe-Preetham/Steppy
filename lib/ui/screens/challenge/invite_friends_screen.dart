import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../data/models/user.dart' as app_models;
import '../../../providers/challenge_provider.dart';
import '../../../services/firestore_service.dart';

class InviteFriendsScreen extends StatefulWidget {
  final String challengeId;

  const InviteFriendsScreen({super.key, required this.challengeId});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  final _searchController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  List<app_models.User> _searchResults = [];
  bool _isSearching = false;

  Future<void> _performSearch(String query) async {
    if (query.trim().length < 2) return;
    setState(() => _isSearching = true);
    try {
      final results = await _firestoreService.searchUsers(query.trim());
      setState(() => _searchResults = results);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Search error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite Friends'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Done'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Friends to Invite',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _performSearch(_searchController.text),
                ),
              ),
              onSubmitted: _performSearch,
            ),
            const SizedBox(height: 16),
            if (_isSearching)
              const CircularProgressIndicator()
            else
              Expanded(
                child: _searchResults.isEmpty
                    ? const Center(child: Text('No users found'))
                    : ListView.separated(
                        itemCount: _searchResults.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final user = _searchResults[index];
                          return Card(
                            child: ListTile(
                              title: Text(user.username),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  context.read<ChallengeProvider>().joinChallenge(
                                        challengeId: widget.challengeId,
                                        userId: user.id,
                                        username: user.username,
                                        profileImageUrl: user.profileImageUrl,
                                      );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Invited ${user.username}')),
                                  );
                                },
                                child: const Text('Invite'),
                              ),
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
