class LeaderboardEntry {
  final String userId;
  final String userName;
  final int rank;
  final double totalPoints;
  final int successfulDays;
  final double successRate;
  final String currentGrade;

  LeaderboardEntry({
    required this.userId,
    required this.userName,
    required this.rank,
    required this.totalPoints,
    required this.successfulDays,
    required this.successRate,
    required this.currentGrade,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'rank': rank,
      'totalPoints': totalPoints,
      'successfulDays': successfulDays,
      'successRate': successRate,
      'currentGrade': currentGrade,
    };
  }

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userId: json['userId'],
      userName: json['userName'],
      rank: json['rank'],
      totalPoints: (json['totalPoints'] as num).toDouble(),
      successfulDays: json['successfulDays'],
      successRate: (json['successRate'] as num).toDouble(),
      currentGrade: json['currentGrade'],
    );
  }
}

class Leaderboard {
  final List<LeaderboardEntry> entries;
  final DateTime lastUpdated;
  final String timeRange;

  Leaderboard({
    required this.entries,
    required this.lastUpdated,
    this.timeRange = 'weekly',
  });

  Map<String, dynamic> toJson() {
    return {
      'entries': entries.map((e) => e.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'timeRange': timeRange,
    };
  }

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      entries: (json['entries'] as List)
          .map((e) => LeaderboardEntry.fromJson(e))
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated']),
      timeRange: json['timeRange'],
    );
  }
}