import 'package:cloud_firestore/cloud_firestore.dart';

class Challenge {
  final String id;
  final String name;
  final String description;
  final int stepGoal;
  final String creatorId;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String> participantIds;

  Challenge({
    required this.id,
    required this.name,
    required this.description,
    required this.stepGoal,
    required this.creatorId,
    this.startDate,
    this.endDate,
    this.participantIds = const [],
  });

  factory Challenge.fromMap(Map<String, dynamic> map, String id) {
    return Challenge(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      stepGoal: (map['stepGoal'] as num?)?.toInt() ?? 0,
      creatorId: map['creatorId'] ?? '',
      startDate: (map['startDate'] as Timestamp?)?.toDate(),
      endDate: (map['endDate'] as Timestamp?)?.toDate(),
      participantIds: List<String>.from(map['participantIds'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'stepGoal': stepGoal,
      'creatorId': creatorId,
      if (startDate != null) 'startDate': Timestamp.fromDate(startDate!),
      if (endDate != null) 'endDate': Timestamp.fromDate(endDate!),
      'participantIds': participantIds,
    };
  }
}
