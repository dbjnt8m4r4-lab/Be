
class ProgressEntry {
  final String id;
  final DateTime date;
  final String note;
  final double progressChange;

  ProgressEntry({
    required this.id,
    required this.date,
    required this.note,
    required this.progressChange,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'note': note,
      'progressChange': progressChange,
    };
  }

  factory ProgressEntry.fromJson(Map<String, dynamic> json) {
    return ProgressEntry(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      note: json['note'] as String,
      progressChange: (json['progressChange'] as num).toDouble(),
    );
  }
}

class Goal {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? targetDate;
  final bool hasAIAssistant;
  final String? aiAssistantId;
  final double progress;
  final List<ProgressEntry> progressEntries;
  final bool isCompleted;
  final DateTime? completedAt;

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.targetDate,
    required this.hasAIAssistant,
    this.aiAssistantId,
    required this.progress,
    required this.progressEntries,
    required this.isCompleted,
    this.completedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'targetDate': targetDate?.toIso8601String(),
      'hasAIAssistant': hasAIAssistant,
      'aiAssistantId': aiAssistantId,
      'progress': progress,
      'progressEntries': progressEntries.map((e) => e.toJson()).toList(),
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      targetDate: json['targetDate'] != null
          ? DateTime.parse(json['targetDate'] as String)
          : null,
      hasAIAssistant: json['hasAIAssistant'] as bool? ?? false,
      aiAssistantId: json['aiAssistantId'] as String?,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      progressEntries: (json['progressEntries'] as List<dynamic>?)
              ?.map((e) => ProgressEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  Goal copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? targetDate,
    bool? hasAIAssistant,
    String? aiAssistantId,
    double? progress,
    List<ProgressEntry>? progressEntries,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return Goal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      targetDate: targetDate ?? this.targetDate,
      hasAIAssistant: hasAIAssistant ?? this.hasAIAssistant,
      aiAssistantId: aiAssistantId ?? this.aiAssistantId,
      progress: progress ?? this.progress,
      progressEntries: progressEntries ?? this.progressEntries,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

