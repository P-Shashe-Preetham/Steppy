import 'package:health/health.dart';

class HealthService {
  final HealthFactory _health = HealthFactory();

  Future<bool> requestPermissions() async {
    final types = [HealthDataType.STEPS];
    final permissions = [HealthDataAccess.READ_WRITE];
    return await _health.requestAuthorization(types, permissions: permissions);
  }

  Future<int> getTodaySteps() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    return await _health.getTotalStepsInInterval(startOfDay, now) ?? 0;
  }

  Future<List<HealthDataPoint>> getWeeklySteps() async {
    final now = DateTime.now();
    final lastWeek = now.subtract(const Duration(days: 7));
    return await _health.getHealthDataFromTypes(lastWeek, now, [HealthDataType.STEPS]);
  }
}
