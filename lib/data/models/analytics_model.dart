class DailyAnalytics {
  final DateTime date;
  final double pointsEarned;
  final int tasksCompleted;
  final int totalTasks;
  final String grade;
  final bool isSuccessfulDay;

  DailyAnalytics({
    required this.date,
    required this.pointsEarned,
    required this.tasksCompleted,
    required this.totalTasks,
    required this.grade,
    required this.isSuccessfulDay,
  });

  double get completionRate => totalTasks > 0 ? tasksCompleted / totalTasks : 0;

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'pointsEarned': pointsEarned,
      'tasksCompleted': tasksCompleted,
      'totalTasks': totalTasks,
      'grade': grade,
      'isSuccessfulDay': isSuccessfulDay,
    };
  }

  factory DailyAnalytics.fromJson(Map<String, dynamic> json) {
    return DailyAnalytics(
      date: DateTime.parse(json['date']),
      pointsEarned: (json['pointsEarned'] as num).toDouble(),
      tasksCompleted: json['tasksCompleted'],
      totalTasks: json['totalTasks'],
      grade: json['grade'],
      isSuccessfulDay: json['isSuccessfulDay'],
    );
  }
}

class MonthlyAnalytics {
  final int year;
  final int month;
  final int successfulDays;
  final int totalDays;
  final double averagePoints;
  final String consistencyGrade;
  final Map<DateTime, DailyAnalytics> dailyData;

  MonthlyAnalytics({
    required this.year,
    required this.month,
    required this.successfulDays,
    required this.totalDays,
    required this.averagePoints,
    required this.consistencyGrade,
    required this.dailyData,
  });

  double get successRate => totalDays > 0 ? successfulDays / totalDays : 0;

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'month': month,
      'successfulDays': successfulDays,
      'totalDays': totalDays,
      'averagePoints': averagePoints,
      'consistencyGrade': consistencyGrade,
      'dailyData': dailyData.map((key, value) => 
          MapEntry(key.toIso8601String(), value.toJson())),
    };
  }

  factory MonthlyAnalytics.fromJson(Map<String, dynamic> json) {
    return MonthlyAnalytics(
      year: json['year'],
      month: json['month'],
      successfulDays: json['successfulDays'],
      totalDays: json['totalDays'],
      averagePoints: (json['averagePoints'] as num).toDouble(),
      consistencyGrade: json['consistencyGrade'],
      dailyData: (json['dailyData'] as Map<String, dynamic>).map((key, value) => 
          MapEntry(DateTime.parse(key), DailyAnalytics.fromJson(value))),
    );
  }
}