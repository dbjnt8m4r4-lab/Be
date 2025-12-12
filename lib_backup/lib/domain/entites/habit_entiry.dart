class HabitEntity {
  final String id;
  final String name;
  final String description;
  final int targetDays;
  final int currentStreak;
  final bool isActive;

  HabitEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.targetDays,
    this.currentStreak = 0,
    this.isActive = true,
  });

  double get completionRate {
    if (targetDays == 0) return 0.0;
    return currentStreak / targetDays;
  }

  bool get isOnTrack => completionRate >= 0.8;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'HabitEntity{id: $id, name: $name, streak: $currentStreak}';
  }
}