import 'dart:developer';
import '../models/habit_model.dart';
import '../datasources/local_database.dart';

class HabitRepository {
  final LocalDatabase _localDatabase = LocalDatabase();

  Future<List<Habit>> getHabits() async {
    try {
      final habitsData = await _localDatabase.getList('habits') ?? [];
      return habitsData.map((data) => Habit.fromJson(data)).toList();
    } catch (e) {
      log('Error getting habits: $e', error: e);
      return [];
    }
  }

  Future<void> saveHabit(Habit habit) async {
    try {
      final habits = await getHabits();
      habits.add(habit);
      await _localDatabase.saveList('habits', habits.map((h) => h.toJson()).toList());
    } catch (e) {
      log('Error saving habit: $e', error: e);
      rethrow;
    }
  }

  Future<void> updateHabit(Habit habit) async {
    try {
      final habits = await getHabits();
      final index = habits.indexWhere((h) => h.id == habit.id);
      if (index != -1) {
        habits[index] = habit;
        await _localDatabase.saveList('habits', habits.map((h) => h.toJson()).toList());
      }
    } catch (e) {
      log('Error updating habit: $e', error: e);
      rethrow;
    }
  }

  Future<void> deleteHabit(String habitId) async {
    try {
      final habits = await getHabits();
      habits.removeWhere((h) => h.id == habitId);
      await _localDatabase.saveList('habits', habits.map((h) => h.toJson()).toList());
    } catch (e) {
      log('Error deleting habit: $e', error: e);
      rethrow;
    }
  }

  Future<void> markHabitCompleted(String habitId, DateTime date) async {
    try {
      final habits = await getHabits();
      final habit = habits.firstWhere((h) => h.id == habitId);
      final updatedHabit = Habit(
        id: habit.id,
        name: habit.name,
        description: habit.description,
        targetDays: habit.targetDays,
        currentStreak: habit.currentStreak + 1,
        longestStreak: habit.longestStreak > habit.currentStreak + 1 
            ? habit.longestStreak 
            : habit.currentStreak + 1,
        startDate: habit.startDate,
        completedDates: [...habit.completedDates, date],
        category: habit.category,
        isActive: habit.isActive,
      );
      await updateHabit(updatedHabit);
    } catch (e) {
      log('Error marking habit completed: $e', error: e);
      rethrow;
    }
  }

  Future<void> toggleHabitDate(String habitId, DateTime date) async {
    try {
      final habits = await getHabits();
      final habit = habits.firstWhere((h) => h.id == habitId);
      
      // Normalize dates to just year/month/day for comparison
      final normalizedDate = DateTime(date.year, date.month, date.day);
      final isCompleted = habit.completedDates.any((completedDate) {
        final normalized = DateTime(completedDate.year, completedDate.month, completedDate.day);
        return normalized == normalizedDate;
      });
      
      List<DateTime> newCompletedDates;
      if (isCompleted) {
        // Remove the date
        newCompletedDates = habit.completedDates.where((completedDate) {
          final normalized = DateTime(completedDate.year, completedDate.month, completedDate.day);
          return normalized != normalizedDate;
        }).toList();
      } else {
        // Add the date
        newCompletedDates = [...habit.completedDates, normalizedDate];
      }
      
      // Recalculate streaks
      int currentStreak = 0;
      int longestStreak = 0;
      int tempStreak = 0;
      final sortedDates = newCompletedDates.toList()..sort((a, b) => a.compareTo(b));
      
      for (int i = 0; i < sortedDates.length; i++) {
        if (i == 0 || sortedDates[i].difference(sortedDates[i - 1]).inDays == 1) {
          tempStreak++;
        } else {
          tempStreak = 1;
        }
        if (tempStreak > longestStreak) {
          longestStreak = tempStreak;
        }
      }
      
      // Calculate current streak from today backwards
      final today = DateTime.now();
      final todayNormalized = DateTime(today.year, today.month, today.day);
      tempStreak = 0;
      for (int i = sortedDates.length - 1; i >= 0; i--) {
        final dateNormalized = DateTime(sortedDates[i].year, sortedDates[i].month, sortedDates[i].day);
        final daysDiff = todayNormalized.difference(dateNormalized).inDays;
        if (daysDiff == tempStreak) {
          tempStreak++;
        } else {
          break;
        }
      }
      currentStreak = tempStreak;
      
      final updatedHabit = Habit(
        id: habit.id,
        name: habit.name,
        description: habit.description,
        targetDays: habit.targetDays,
        currentStreak: currentStreak,
        longestStreak: longestStreak > habit.longestStreak ? longestStreak : habit.longestStreak,
        startDate: habit.startDate,
        completedDates: newCompletedDates,
        category: habit.category,
        isActive: habit.isActive,
      );
      await updateHabit(updatedHabit);
    } catch (e) {
      log('Error toggling habit date: $e', error: e);
      rethrow;
    }
  }
}