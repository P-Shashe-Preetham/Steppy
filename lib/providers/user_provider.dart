import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  int _todaySteps = 8520;
  int _totalSteps = 124500;
  int _dailyGoal = 10000;
  int _streak = 7;
  int _coins = 420;
  int _xp = 2400;
  int _level = 4;
  int _xpNextLevel = 3000;

  int get steps => _todaySteps;
  int get todaySteps => _todaySteps;
  int get totalSteps => _totalSteps;
  int get dailyGoal => _dailyGoal;
  int get streak => _streak;
  int get coins => _coins;
  int get xp => _xp;
  int get level => _level;
  int get xpNextLevel => _xpNextLevel;

  double get progressFraction => (_todaySteps / _dailyGoal).clamp(0.0, 1.0);
  double get xpProgressFraction => (_xp / _xpNextLevel).clamp(0.0, 1.0);

  void updateSteps(int steps) {
    _todaySteps = steps;
    notifyListeners();
  }

  void setDailyGoal(int goal) {
    _dailyGoal = goal;
    notifyListeners();
  }

  void syncSteps([int amount = 750]) {
    _todaySteps += amount;
    _totalSteps += amount;
    final xpGained = (amount / 10).round();
    _xp += xpGained;
    _coins += (amount / 200).round();

    if (_xp >= _xpNextLevel) {
      _level += 1;
      _xpNextLevel += 1000;
      _coins += 50; // Level up reward
    }

    notifyListeners();
  }

  bool canAfford(int cost) => _coins >= cost;

  bool redeem(int cost) {
    if (_coins < cost) return false;
    _coins -= cost;
    notifyListeners();
    return true;
  }
}
