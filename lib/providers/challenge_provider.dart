import 'dart:async';
import 'package:flutter/material.dart';
import '../models/challenge.dart';
import '../models/participant.dart';
import '../services/firestore_service.dart';

class ChallengeProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Challenge> _challenges = [];
  List<Challenge> get challenges => _challenges;

  Challenge? _currentChallenge;
  Challenge? get currentChallenge => _currentChallenge;

  List<Participant> _participants = [];
  List<Participant> get participants => _participants;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StreamSubscription<List<Challenge>>? _challengesSubscription;
  StreamSubscription<Challenge?>? _currentChallengeSubscription;
  StreamSubscription<List<Participant>>? _participantsSubscription;

  ChallengeProvider() {
    listenToChallenges();
  }

  void listenToChallenges() {
    _challengesSubscription?.cancel();
    _challengesSubscription = _firestoreService.getChallengesStream().listen((list) {
      _challenges = list;
      notifyListeners();
    });
  }

  void listenToChallengeDetail(String challengeId) {
    _currentChallengeSubscription?.cancel();
    _currentChallengeSubscription = _firestoreService.getChallengeStream(challengeId).listen((challenge) {
      _currentChallenge = challenge;
      notifyListeners();
    });

    _participantsSubscription?.cancel();
    _participantsSubscription = _firestoreService.getParticipantsStream(challengeId).listen((list) {
      _participants = list;
      notifyListeners();
    });
  }

  Future<String?> createChallenge(Challenge challenge) async {
    _isLoading = true;
    notifyListeners();
    try {
      final docId = await _firestoreService.createChallenge(challenge);
      _isLoading = false;
      notifyListeners();
      return docId;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> joinChallenge({
    required String challengeId,
    required String userId,
    required String username,
    required String profileImageUrl,
  }) async {
    await _firestoreService.joinChallenge(
      challengeId: challengeId,
      userId: userId,
      username: username,
      profileImageUrl: profileImageUrl,
    );
  }

  Future<void> updateParticipantSteps({
    required String challengeId,
    required String userId,
    required int steps,
  }) async {
    await _firestoreService.updateParticipantSteps(
      challengeId: challengeId,
      userId: userId,
      steps: steps,
    );
  }

  @override
  void dispose() {
    _challengesSubscription?.cancel();
    _currentChallengeSubscription?.cancel();
    _participantsSubscription?.cancel();
    super.dispose();
  }
}
