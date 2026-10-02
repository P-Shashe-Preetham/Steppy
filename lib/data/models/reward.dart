import 'package:cloud_firestore/cloud_firestore.dart';

class Reward {
  final String id;
  final String name;
  final String description;
  final int cost;
  final String imageUrl;

  Reward({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.imageUrl,
  });

  factory Reward.fromMap(Map<String, dynamic> map, String id) {
    return Reward(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      cost: (map['cost'] as num?)?.toInt() ?? 0,
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'cost': cost,
      'imageUrl': imageUrl,
    };
  }
}

class Redemption {
  final String id;
  final String userId;
  final String rewardId;
  final DateTime timestamp;

  Redemption({
    required this.id,
    required this.userId,
    required this.rewardId,
    required this.timestamp,
  });

  factory Redemption.fromMap(Map<String, dynamic> map, String id) {
    return Redemption(
      id: id,
      userId: map['userId'] ?? '',
      rewardId: map['rewardId'] ?? '',
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rewardId': rewardId,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
