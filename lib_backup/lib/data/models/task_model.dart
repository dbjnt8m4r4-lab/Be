import 'package:flutter/material.dart';

// نموذج جديد للخيارات الفرعية
class SubTaskOption {
  final String id;
  final String title;
  final String priority;
  final double pointsWeight; // وزن النقاط لهذا الخيار
  
  SubTaskOption({
    required this.id,
    required this.title,
    required this.priority,
    this.pointsWeight = 1.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'priority': priority,
      'pointsWeight': pointsWeight,
    };
  }

  factory SubTaskOption.fromJson(Map<String, dynamic> json) {
    return SubTaskOption(
      id: json['id'],
      title: json['title'],
      priority: json['priority'],
      pointsWeight: (json['pointsWeight'] as num).toDouble(),
    );
  }
}

enum RepetitionType {
  none,
  daily,
  customDays, // Every N days
  weekly,
  monthly,
  multiplePerDay,
}

class Repetition {
  final RepetitionType type;
  final int? interval; // For customDays (e.g., every 3 days)
  final List<int>? daysOfWeek; // For weekly (1=Monday, 7=Sunday)
  final int? dayOfMonth; // For monthly
  final int targetCount; // For multiplePerDay (default 1)
  final List<TimeOfDay>? times; // For multiplePerDay specific times

  Repetition({
    this.type = RepetitionType.none,
    this.interval,
    this.daysOfWeek,
    this.dayOfMonth,
    this.targetCount = 1,
    this.times,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'interval': interval,
      'daysOfWeek': daysOfWeek,
      'dayOfMonth': dayOfMonth,
      'targetCount': targetCount,
      'times': times?.map((t) => '${t.hour}:${t.minute}').toList(),
    };
  }

  factory Repetition.fromJson(Map<String, dynamic> json) {
    return Repetition(
      type: RepetitionType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => RepetitionType.none,
      ),
      interval: json['interval'],
      daysOfWeek: json['daysOfWeek'] != null ? List<int>.from(json['daysOfWeek']) : null,
      dayOfMonth: json['dayOfMonth'],
      targetCount: json['targetCount'] ?? 1,
      times: json['times'] != null
          ? (json['times'] as List).map((t) => _parseTimeOfDay(t)).toList()
          : null,
    );
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}

class Task {
  final String id;
  final String title;
  final String description;
  final String priority;
  final DateTime? dueDate;
  final TimeOfDay? reminderTime;
  final int estimatedDuration;
  final double assignedPoints;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? category;
  final bool isRecurring; // Legacy flag, kept for backward compatibility but logic moved to repetition
  final List<String> tags;
  final bool isQuickTemplate;
  final String? templateCategory;
  final List<SubTaskOption> subTaskOptions;
  
  // New fields for enhanced repetition
  final Repetition? repetition;
  final int completedCount; // Current progress for multiplePerDay

  Task({
    required this.id,
    required this.title,
    required this.priority,
    this.description = '',
    this.dueDate,
    this.reminderTime,
    this.estimatedDuration = 60,
    this.assignedPoints = 0,
    this.isCompleted = false,
    required this.createdAt,
    this.completedAt,
    this.category,
    this.isRecurring = false,
    this.tags = const [],
    this.isQuickTemplate = false,
    this.templateCategory,
    this.subTaskOptions = const [],
    this.repetition,
    this.completedCount = 0,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    DateTime? dueDate,
    TimeOfDay? reminderTime,
    int? estimatedDuration,
    double? assignedPoints,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
    String? category,
    bool? isRecurring,
    List<String>? tags,
    bool? isQuickTemplate,
    String? templateCategory,
    List<SubTaskOption>? subTaskOptions,
    Repetition? repetition,
    int? completedCount,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      reminderTime: reminderTime ?? this.reminderTime,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      assignedPoints: assignedPoints ?? this.assignedPoints,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      category: category ?? this.category,
      isRecurring: isRecurring ?? this.isRecurring,
      tags: tags ?? this.tags,
      isQuickTemplate: isQuickTemplate ?? this.isQuickTemplate,
      templateCategory: templateCategory ?? this.templateCategory,
      subTaskOptions: subTaskOptions ?? this.subTaskOptions,
      repetition: repetition ?? this.repetition,
      completedCount: completedCount ?? this.completedCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'dueDate': dueDate?.toIso8601String(),
      'reminderTime': reminderTime != null ? 
          '${reminderTime!.hour}:${reminderTime!.minute}' : null,
      'estimatedDuration': estimatedDuration,
      'assignedPoints': assignedPoints,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'category': category,
      'isRecurring': isRecurring,
      'tags': tags,
      'isQuickTemplate': isQuickTemplate,
      'templateCategory': templateCategory,
      'subTaskOptions': subTaskOptions.map((e) => e.toJson()).toList(),
      'repetition': repetition?.toJson(),
      'completedCount': completedCount,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      reminderTime: json['reminderTime'] != null ? 
          _parseTimeOfDay(json['reminderTime']) : null,
      estimatedDuration: json['estimatedDuration'],
      assignedPoints: (json['assignedPoints'] as num).toDouble(),
      isCompleted: json['isCompleted'],
      createdAt: DateTime.parse(json['createdAt']),
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
      category: json['category'],
      isRecurring: json['isRecurring'] ?? false,
      tags: List<String>.from(json['tags'] ?? []),
      isQuickTemplate: json['isQuickTemplate'] ?? false,
      templateCategory: json['templateCategory'],
      subTaskOptions: json['subTaskOptions'] != null
          ? (json['subTaskOptions'] as List).map((e) => SubTaskOption.fromJson(e)).toList()
          : [],
      repetition: json['repetition'] != null ? Repetition.fromJson(json['repetition']) : null,
      completedCount: json['completedCount'] ?? 0,
    );
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}