class User {
  final String id;
  final String email;
  final String? name;
  final String? photoUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? totalCompletedDays;
  final int? totalTasksAddedDays;
  final bool? leaderboardEligible;
  final double? averageScore;
  final String? fcmToken;
  final int? totalPoints;
  final int? successfulDays;
  final int? totalDays;
  final String? currentGrade;
  final Map<String, dynamic>? preferences;

  User({
    required this.id,
    required this.email,
    this.name,
    this.photoUrl,
    this.createdAt,
    this.updatedAt,
    this.totalCompletedDays = 0,
    this.totalTasksAddedDays = 0,
    this.leaderboardEligible = false,
    this.averageScore = 0.0,
    this.fcmToken,
    this.totalPoints = 0,
    this.successfulDays = 0,
    this.totalDays = 0,
    this.currentGrade,
    this.preferences,
  });

  // ADD THESE MISSING METHODS
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      photoUrl: json['photoUrl'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      totalCompletedDays: json['totalCompletedDays'] ?? 0,
      totalTasksAddedDays: json['totalTasksAddedDays'] ?? 0,
      leaderboardEligible: json['leaderboardEligible'] ?? false,
      averageScore: json['averageScore'] != null ? double.parse(json['averageScore'].toString()) : 0.0,
      fcmToken: json['fcmToken'],
      totalPoints: json['totalPoints'] ?? 0,
      successfulDays: json['successfulDays'] ?? 0,
      totalDays: json['totalDays'] ?? 0,
      currentGrade: json['currentGrade'],
      preferences: json['preferences'] != null ? Map<String, dynamic>.from(json['preferences']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'totalCompletedDays': totalCompletedDays,
      'totalTasksAddedDays': totalTasksAddedDays,
      'leaderboardEligible': leaderboardEligible,
      'averageScore': averageScore,
      'fcmToken': fcmToken,
      'totalPoints': totalPoints,
      'successfulDays': successfulDays,
      'totalDays': totalDays,
      'currentGrade': currentGrade,
      'preferences': preferences,
    };
  }
}