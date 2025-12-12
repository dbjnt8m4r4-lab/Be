import 'package:flutter/material.dart';
import '../../../data/models/habit_model.dart';
import '../../../core/utils/habit_points_calculator.dart';
import '../../../core/widgets/achievement_unlock_dialog.dart';
import '../../../data/models/achievement_model.dart';

class HabitProvider with ChangeNotifier {
  final List<Habit> _habits = [];
  final bool _isLoading = false;

  List<Habit> get habits => _habits;
  bool get isLoading => _isLoading;

  void toggleHabitCompletion(String habitId, DateTime date) {
    toggleHabitDate(habitId, date);
  }

  // Add a new habit
  void addHabit(Habit habit) {
    _habits.add(habit);
    _distributePoints();
    notifyListeners();
  }

  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  // Mark a habit as completed for today
  void markHabitCompleted(String habitId) {
    final habitIndex = _habits.indexWhere((h) => h.id == habitId);
    if (habitIndex != -1) {
      final habit = _habits[habitIndex];
      final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      
      // Check if already completed today
      final isCompletedToday = habit.completedDates.any((date) =>
          date.year == today.year && date.month == today.month && date.day == today.day);
      
      if (!isCompletedToday) {
        // Create new habit with updated completedDates
        final updatedCompletedDates = [...habit.completedDates, today];
        final newStreak = _calculateStreak(updatedCompletedDates);
        
        _habits[habitIndex] = habit.copyWith(
          currentStreak: newStreak,
          longestStreak: newStreak > habit.longestStreak ? newStreak : habit.longestStreak,
          completedDates: updatedCompletedDates,
        );
        notifyListeners();
        _checkAndShowWinning(habit.name);
      }
    }
  }

  int _calculateStreak(List<DateTime> completedDates) {
    if (completedDates.isEmpty) return 0;
    
    // Sort dates in descending order
    final sorted = List<DateTime>.from(completedDates)..sort((a, b) => b.compareTo(a));
    
    int streak = 0;
    DateTime currentDate = DateTime.now();
    final today = DateTime(currentDate.year, currentDate.month, currentDate.day);
    
    // Check consecutive days from today backwards
    for (int i = 0; i < sorted.length; i++) {
      final date = sorted[i];
      final expectedDate = today.subtract(Duration(days: i));
      final normalizedExpected = DateTime(expectedDate.year, expectedDate.month, expectedDate.day);
      final normalizedDate = DateTime(date.year, date.month, date.day);
      
      if (normalizedDate == normalizedExpected) {
        streak++;
      } else {
        break;
      }
    }
    
    return streak;
  }

  void deleteHabit(String habitId) {
    _habits.removeWhere((habit) => habit.id == habitId);
    notifyListeners();
  }

  double getOverallCompletionRate() {
    if (_habits.isEmpty) return 0.0;
    
    int totalCompletions = 0;
    int totalPossible = 0;
    
    for (final habit in _habits) {
      totalCompletions += habit.completedDates.length;
      totalPossible += habit.targetDays;
    }
    
    return totalPossible > 0 ? totalCompletions / totalPossible : 0.0;
  }

  void toggleHabitDate(String habitId, DateTime date) {
    final habitIndex = _habits.indexWhere((h) => h.id == habitId);
    if (habitIndex != -1) {
      final habit = _habits[habitIndex];
      final normalizedDate = DateTime(date.year, date.month, date.day);
      
      // Check if date already exists
      final dateExists = habit.completedDates.any((d) =>
          d.year == normalizedDate.year && d.month == normalizedDate.month && d.day == normalizedDate.day);
      
      List<DateTime> updatedDates;
      bool added = false;
      if (dateExists) {
        // Remove the date
        updatedDates = habit.completedDates
            .where((d) => !(d.year == normalizedDate.year && d.month == normalizedDate.month && d.day == normalizedDate.day))
            .toList();
      } else {
        // Add the date
        updatedDates = [...habit.completedDates, normalizedDate];
        added = true;
      }
      
      final newStreak = _calculateStreak(updatedDates);
      
      _habits[habitIndex] = habit.copyWith(
        currentStreak: newStreak,
        longestStreak: newStreak > habit.longestStreak ? newStreak : habit.longestStreak,
        completedDates: updatedDates,
      );
      
      _distributePoints();
      notifyListeners();

      if (added) {
        _checkAndShowWinning(habit.name);
      }
    }
  }

  void _checkAndShowWinning(String habitName) {
    if (_context != null && _context!.mounted) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_context != null && _context!.mounted) {
          // Create achievement for habit completion
          final achievement = Achievement(
            id: 'habit_completed_${DateTime.now().millisecondsSinceEpoch}',
            title: 'Great Job!',
            description: 'You completed "$habitName" for today!',
            badgeIcon: 'assets/images/trophy.png',
            emoji: '🎯',
            type: AchievementType.habitCompleted,
            rarity: AchievementRarity.common,
            pointsReward: 5,
            metadata: {
              'conditionType': 'habit',
              'conditionValue': 1,
            },
          );
           
          showDialog(
            context: _context!,
            builder: (context) => AchievementUnlockDialog(achievement: achievement),
          );
        }
      });
    }
  }

  void _distributePoints() {
    final pointsMap = HabitPointsCalculator.calculatePoints(_habits);
    
    for (var habit in _habits) {
      final points = pointsMap[habit.id] ?? 0;
      if (habit.assignedPoints != points) {
        final index = _habits.indexWhere((h) => h.id == habit.id);
        _habits[index] = habit.copyWith(assignedPoints: points);
      }
    }
  }

  List<Habit> getTodayCompletedHabits() {
    return HabitPointsCalculator.getTodayCompletedHabits(_habits);
  }

  double getTodayPoints() {
    final todayCompletedHabits = getTodayCompletedHabits();
    return HabitPointsCalculator.calculateDailyPoints(todayCompletedHabits);
  }
}