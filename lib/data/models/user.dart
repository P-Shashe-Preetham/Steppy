class User {
  final String id;
  final String email;
  final String username;
  final String profileImageUrl;
  final int totalSteps;
  final int xp;
  final int level;
  final List<String> earnedBadgeIds;
  final int coins;

  User({
    required this.id,
    required this.email,
    required this.username,
    this.profileImageUrl = '',
    this.totalSteps = 0,
    this.xp = 0,
    this.level = 1,
    this.earnedBadgeIds = const [],
    this.coins = 0,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      totalSteps: (map['totalSteps'] as num?)?.toInt() ?? 0,
      xp: (map['xp'] as num?)?.toInt() ?? 0,
      level: (map['level'] as num?)?.toInt() ?? 1,
      earnedBadgeIds: List<String>.from(map['earnedBadgeIds'] ?? []),
      coins: (map['coins'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'totalSteps': totalSteps,
      'xp': xp,
      'level': level,
      'earnedBadgeIds': earnedBadgeIds,
      'coins': coins,
    };
  }
}
