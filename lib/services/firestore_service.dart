import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/challenge.dart';
import '../models/participant.dart';
import '../models/reward.dart';
import '../models/user.dart' as app_models;

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- User Stats & Token ---
  Future<void> updateUserStats(int steps, int xp, int level, List<String> newBadgeIds) async {
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      Map<String, dynamic> updates = {
        'totalSteps': steps,
        'xp': xp,
        'level': level,
      };
      if (newBadgeIds.isNotEmpty) {
        updates['earnedBadgeIds'] = FieldValue.arrayUnion(newBadgeIds);
      }
      await _firestore.collection('users').doc(uid).update(updates);
    }
  }

  Future<void> updateFcmToken(String token) async {
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection('users').doc(uid).update({'fcmToken': token});
    }
  }

  Future<List<app_models.User>> searchUsers(String query) async {
    if (query.isEmpty) return [];
    final snapshot = await _firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query)
        .where('username', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    return snapshot.docs.map((doc) => app_models.User.fromMap({...doc.data(), 'id': doc.id})).toList();
  }

  // --- Challenges ---
  Stream<List<Challenge>> getChallengesStream() {
    return _firestore.collection('challenges').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Challenge.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Stream<Challenge?> getChallengeStream(String challengeId) {
    return _firestore.collection('challenges').doc(challengeId).snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      return Challenge.fromMap(snapshot.data()!, snapshot.id);
    });
  }

  Stream<List<Participant>> getParticipantsStream(String challengeId) {
    return _firestore
        .collection('challenges')
        .doc(challengeId)
        .collection('participants')
        .orderBy('steps', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Participant.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Future<String> createChallenge(Challenge challenge) async {
    final docRef = await _firestore.collection('challenges').add(challenge.toMap());
    return docRef.id;
  }

  Future<void> joinChallenge({
    required String challengeId,
    required String userId,
    required String username,
    required String profileImageUrl,
  }) async {
    final participant = Participant(
      id: userId,
      challengeId: challengeId,
      userId: userId,
      username: username,
      profileImageUrl: profileImageUrl,
      steps: 0,
      hasJoined: true,
    );

    await _firestore
        .collection('challenges')
        .doc(challengeId)
        .collection('participants')
        .doc(userId)
        .set(participant.toMap());

    await _firestore.collection('challenges').doc(challengeId).update({
      'participantIds': FieldValue.arrayUnion([userId])
    });
  }

  Future<void> updateParticipantSteps({
    required String challengeId,
    required String userId,
    required int steps,
  }) async {
    await _firestore
        .collection('challenges')
        .doc(challengeId)
        .collection('participants')
        .doc(userId)
        .update({'steps': steps});
  }

  // --- Rewards ---
  Stream<List<Reward>> getRewardsStream() {
    return _firestore.collection('rewards').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Reward.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Future<void> redeemReward({required String userId, required Reward reward}) async {
    return _firestore.runTransaction((transaction) async {
      final userRef = _firestore.collection('users').doc(userId);
      final userSnapshot = await transaction.get(userRef);

      if (!userSnapshot.exists) {
        throw Exception("User does not exist");
      }

      final currentCoins = (userSnapshot.data()?['coins'] as num?)?.toInt() ?? 0;

      if (currentCoins < reward.cost) {
        throw Exception("Not enough coins");
      }

      transaction.update(userRef, {'coins': currentCoins - reward.cost});

      final redemptionRef = _firestore.collection('redemptions').doc();
      final redemption = Redemption(
        id: redemptionRef.id,
        userId: userId,
        rewardId: reward.id,
        timestamp: DateTime.now(),
      );

      transaction.set(redemptionRef, redemption.toMap());
    });
  }
}
