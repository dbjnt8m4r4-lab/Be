class TaskEntity {
  final String id;
  final String title;
  final String description;
  final String priority;
  final DateTime? dueDate;
  final int estimatedDuration;
  final double assignedPoints;
  final bool isCompleted;

  TaskEntity({
    required this.id,
    required this.title,
    required this.priority,
    this.description = '',
    this.dueDate,
    this.estimatedDuration = 60,
    this.assignedPoints = 0,
    this.isCompleted = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'TaskEntity{id: $id, title: $title, priority: $priority, completed: $isCompleted}';
  }
}