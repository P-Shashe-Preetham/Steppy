enum BadgeRequirementType {
  totalSteps,
  dailyGoalReached,
  challengeWon,
  streakDays,
}

class Badge {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final BadgeRequirementType requirementType;
  final int requirementValue;

  Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.requirementType,
    required this.requirementValue,
  });

  factory Badge.fromMap(Map<String, dynamic> map, String id) {
    BadgeRequirementType type = BadgeRequirementType.totalSteps;
    final typeStr = map['requirementType'] as String?;
    if (typeStr != null) {
      switch (typeStr) {
        case 'DAILY_GOAL_REACHED':
          type = BadgeRequirementType.dailyGoalReached;
          break;
        case 'CHALLENGE_WON':
          type = BadgeRequirementType.challengeWon;
          break;
        case 'STREAK_DAYS':
          type = BadgeRequirementType.streakDays;
          break;
        default:
          type = BadgeRequirementType.totalSteps;
      }
    }

    return Badge(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      iconUrl: map['iconUrl'] ?? '',
      requirementType: type,
      requirementValue: (map['requirementValue'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'iconUrl': iconUrl,
      'requirementType': requirementType.name,
      'requirementValue': requirementValue,
    };
  }
}
