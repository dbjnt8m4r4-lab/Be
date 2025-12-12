enum AchievementType {
  taskCompleted,
  streakMaintained,
  pointsEarned,
  habitCompleted,
  dailyGoal,
  weeklyGoal,
  hidden,
  seasonal,
  timeLimited,
}

enum AchievementRarity {
  common,
  rare,
  epic,
  legendary,
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final AchievementType type;
  final AchievementRarity rarity;
  final bool isHidden;
  final bool isTimeLimited;
  final DateTime? expiresAt;
  final int pointsReward;
  final String? badgeIcon;
  final Map<String, dynamic>? metadata;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.type,
    this.rarity = AchievementRarity.common,
    this.isHidden = false,
    this.isTimeLimited = false,
    this.expiresAt,
    this.pointsReward = 0,
    this.badgeIcon,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'emoji': emoji,
      'type': type.toString(),
      'rarity': rarity.toString(),
      'isHidden': isHidden,
      'isTimeLimited': isTimeLimited,
      'expiresAt': expiresAt?.toIso8601String(),
      'pointsReward': pointsReward,
      'badgeIcon': badgeIcon,
      'metadata': metadata,
    };
  }

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      emoji: json['emoji'],
      type: AchievementType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => AchievementType.taskCompleted,
      ),
      rarity: AchievementRarity.values.firstWhere(
        (e) => e.toString() == json['rarity'],
        orElse: () => AchievementRarity.common,
      ),
      isHidden: json['isHidden'] ?? false,
      isTimeLimited: json['isTimeLimited'] ?? false,
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      pointsReward: json['pointsReward'] ?? 0,
      badgeIcon: json['badgeIcon'],
      metadata: json['metadata'],
    );
  }
}

class UserAchievement {
  final String achievementId;
  final DateTime unlockedAt;
  final bool isNew;

  UserAchievement({
    required this.achievementId,
    required this.unlockedAt,
    this.isNew = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'achievementId': achievementId,
      'unlockedAt': unlockedAt.toIso8601String(),
      'isNew': isNew,
    };
  }

  factory UserAchievement.fromJson(Map<String, dynamic> json) {
    return UserAchievement(
      achievementId: json['achievementId'],
      unlockedAt: DateTime.parse(json['unlockedAt']),
      isNew: json['isNew'] ?? false,
    );
  }
}





