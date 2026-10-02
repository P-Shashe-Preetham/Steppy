class Participant {
  final String id;
  final String challengeId;
  final String userId;
  final String username;
  final String profileImageUrl;
  final int steps;
  final bool hasJoined;

  Participant({
    required this.id,
    required this.challengeId,
    required this.userId,
    required this.username,
    required this.profileImageUrl,
    required this.steps,
    required this.hasJoined,
  });

  factory Participant.fromMap(Map<String, dynamic> map, String id) {
    return Participant(
      id: id,
      challengeId: map['challengeId'] ?? '',
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      steps: (map['steps'] as num?)?.toInt() ?? 0,
      hasJoined: map['hasJoined'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'challengeId': challengeId,
      'userId': userId,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'steps': steps,
      'hasJoined': hasJoined,
    };
  }
}
