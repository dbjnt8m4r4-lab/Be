class HabitRecord {
  final DateTime date;
  final int occurrences;
  final bool isImproved;

  HabitRecord({
    required this.date,
    required this.occurrences,
    required this.isImproved,
  });
}

class BadHabit {
  final String id;
  final String name;
  final String description;
  final int dailyOccurrences;
  final int targetReduction;
  final DateTime startDate;
  final List<HabitRecord> records;
  final double successRate;
  final String category;
  final bool isActive;

  BadHabit({
    required this.id,
    required this.name,
    required this.description,
    required this.dailyOccurrences,
    required this.targetReduction,
    required this.startDate,
    this.records = const [],
    this.successRate = 0.0,
    this.category = 'عام',
    this.isActive = true,
  });

  BadHabit copyWith({
    String? id,
    String? name,
    String? description,
    int? dailyOccurrences,
    int? targetReduction,
    DateTime? startDate,
    List<HabitRecord>? records,
    double? successRate,
    String? category,
    bool? isActive,
  }) {
    return BadHabit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      dailyOccurrences: dailyOccurrences ?? this.dailyOccurrences,
      targetReduction: targetReduction ?? this.targetReduction,
      startDate: startDate ?? this.startDate,
      records: records ?? this.records,
      successRate: successRate ?? this.successRate,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
    );
  }
}

class Habit {
  final String id;
  final String name;
  final String description;
  final int targetDays;
  final int currentStreak;
  final int longestStreak;
  final DateTime startDate;
  final List<DateTime> completedDates;
  final String category;
  final bool isActive;
  final double assignedPoints;

  Habit({
    required this.id,
    required this.name,
    required this.description,
    required this.targetDays,
    this.currentStreak = 0,
    this.longestStreak = 0,
    required this.startDate,
    this.completedDates = const [],
    this.category = 'general',
    this.isActive = true,
    this.assignedPoints = 0.0,
  });

  double get completionRate {
    if (targetDays == 0) return 0.0;
    return currentStreak / targetDays;
  }

  Habit copyWith({
    String? id,
    String? name,
    String? description,
    int? targetDays,
    int? currentStreak,
    int? longestStreak,
    DateTime? startDate,
    List<DateTime>? completedDates,
    String? category,
    bool? isActive,
    double? assignedPoints,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      targetDays: targetDays ?? this.targetDays,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      startDate: startDate ?? this.startDate,
      completedDates: completedDates ?? this.completedDates,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      assignedPoints: assignedPoints ?? this.assignedPoints,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'targetDays': targetDays,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'startDate': startDate.toIso8601String(),
      'completedDates': completedDates.map((date) => date.toIso8601String()).toList(),
      'category': category,
      'isActive': isActive,
      'assignedPoints': assignedPoints,
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      targetDays: json['targetDays'],
      currentStreak: json['currentStreak'],
      longestStreak: json['longestStreak'],
      startDate: DateTime.parse(json['startDate']),
      completedDates: (json['completedDates'] as List)
          .map((date) => DateTime.parse(date))
          .toList(),
      category: json['category'],
      isActive: json['isActive'],
      assignedPoints: (json['assignedPoints'] as num?)?.toDouble() ?? 0.0,
    );
  }
}