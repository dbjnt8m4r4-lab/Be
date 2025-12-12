enum ChallengeType {
  daily,
  weekly,
  seasonal,
  timeLimited,
  group,
  morning,
  evening,
}

enum ChallengeStatus {
  notStarted,
  inProgress,
  completed,
  expired,
}

class Challenge {
  final String id;
  final String title;
  final String description;
  final ChallengeType type;
  final DateTime startDate;
  final DateTime endDate;
  final int targetValue;
  final int currentValue;
  final int pointsReward;
  final String? emoji;
  final List<String>? participantIds;
  final Map<String, dynamic>? metadata;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.targetValue,
    this.currentValue = 0,
    this.pointsReward = 0,
    this.emoji,
    this.participantIds,
    this.metadata,
  });

  ChallengeStatus get status {
    final now = DateTime.now();
    if (now.isBefore(startDate)) return ChallengeStatus.notStarted;
    if (now.isAfter(endDate)) return ChallengeStatus.expired;
    if (currentValue >= targetValue) return ChallengeStatus.completed;
    return ChallengeStatus.inProgress;
  }

  double get progress => targetValue > 0 ? (currentValue / targetValue).clamp(0.0, 1.0) : 0.0;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.toString(),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'targetValue': targetValue,
      'currentValue': currentValue,
      'pointsReward': pointsReward,
      'emoji': emoji,
      'participantIds': participantIds,
      'metadata': metadata,
    };
  }

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: ChallengeType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => ChallengeType.daily,
      ),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      targetValue: json['targetValue'],
      currentValue: json['currentValue'] ?? 0,
      pointsReward: json['pointsReward'] ?? 0,
      emoji: json['emoji'],
      participantIds: json['participantIds'] != null ? List<String>.from(json['participantIds']) : null,
      metadata: json['metadata'],
    );
  }
}





