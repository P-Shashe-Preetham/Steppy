import 'dart:async';
import 'package:flutter/material.dart';
import '../models/reward.dart';
import '../services/firestore_service.dart';

class RewardProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Reward> _rewards = [];
  List<Reward> get rewards => _rewards;

  bool _isRedeeming = false;
  bool get isRedeeming => _isRedeeming;

  StreamSubscription<List<Reward>>? _rewardsSubscription;

  RewardProvider() {
    listenToRewards();
  }

  void listenToRewards() {
    _rewardsSubscription?.cancel();
    _rewardsSubscription = _firestoreService.getRewardsStream().listen((list) {
      _rewards = list;
      notifyListeners();
    });
  }

  Future<bool> redeemReward({required String userId, required Reward reward}) async {
    _isRedeeming = true;
    notifyListeners();

    try {
      await _firestoreService.redeemReward(userId: userId, reward: reward);
      _isRedeeming = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isRedeeming = false;
      notifyListeners();
      rethrow;
    }
  }

  @override
  void dispose() {
    _rewardsSubscription?.cancel();
    super.dispose();
  }
}
