import 'package:flutter/foundation.dart';

import '../../../data/models/analytics_model.dart';
import '../../../data/models/habit_model.dart';
import '../../../data/models/task_model.dart';

class AnalyticsProvider with ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Map<String, dynamic> _consistencyData = {
    'currentStreak': 0,
    'longestStreak': 0,
    'successRate': 0.0,
  };

  Map<String, dynamic> _weeklySummary = {
    'completedTasks': 0,
    'totalTasks': 0,
    'averagePoints': 0.0,
    'successRate': 0.0,
  };

  List<Map<String, dynamic>> _dailyPointsData = [];
  List<Map<String, dynamic>> _consistencyHistory = [];
  MonthlyAnalytics? _currentMonthlyAnalytics;

  Map<String, dynamic> getConsistencyData() => _consistencyData;
  Map<String, dynamic> getWeeklySummary() => _weeklySummary;
  List<Map<String, dynamic>> getDailyPointsData() => _dailyPointsData;
  List<Map<String, dynamic>> getConsistencyHistory() => _consistencyHistory;
  MonthlyAnalytics? get currentMonthlyAnalytics => _currentMonthlyAnalytics;

  void updateData({
    required List<Task> tasks,
    required List<Habit> habits,
  }) {
    _recalculateAnalytics(tasks, habits);
    if (_isLoading) {
      _isLoading = false;
    }
    notifyListeners();
  }

  void _recalculateAnalytics(List<Task> tasks, List<Habit> habits) {
    final now = DateTime.now();
    final normalizedNow = DateTime(now.year, now.month, now.day);
    final startWindow = normalizedNow.subtract(const Duration(days: 6));

    final Map<DateTime, _DailyStats> stats = {};
    final List<DateTime> completionDates = [];

    _DailyStats getStats(DateTime date) {
      final normalized = DateTime(date.year, date.month, date.day);
      return stats.putIfAbsent(normalized, () => _DailyStats());
    }

    double totalPoints = 0;
    int combinedCompletions = 0;

    for (final task in tasks) {
      final scheduledDate = task.dueDate ?? task.createdAt;
      getStats(scheduledDate).total += 1;
    
      if (task.isCompleted && task.completedAt != null) {
        final stat = getStats(task.completedAt!);
        stat.completed += 1;
        stat.points += task.assignedPoints;
        totalPoints += task.assignedPoints;
        final normalizedCompletion = _normalizeDate(task.completedAt!);
        if (!normalizedCompletion.isBefore(startWindow)) {
          combinedCompletions += 1;
        }
        completionDates.add(normalizedCompletion);
      }
    }

    for (final habit in habits) {
      final habitPoints = habit.assignedPoints > 0 ? habit.assignedPoints : 5;
      for (final date in habit.completedDates) {
        final stat = getStats(date);
        stat.completed += 1;
        stat.points += habitPoints;
        totalPoints += habitPoints;
        final normalizedDate = _normalizeDate(date);
        if (!normalizedDate.isBefore(startWindow)) {
          combinedCompletions += 1;
        }
        completionDates.add(normalizedDate);
      }
    }

    final uniqueCompletionDates = completionDates.toSet().toList()
      ..sort();

    final totalTargets = tasks.length + habits.length;
    final successRate = totalTargets == 0
        ? 0.0
        : (combinedCompletions / totalTargets).clamp(0.0, 1.0);

    _consistencyData = {
      'currentStreak': _calculateCurrentStreak(uniqueCompletionDates),
      'longestStreak': _calculateLongestStreak(uniqueCompletionDates),
      'successRate': successRate,
    };

    const weekdayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    _dailyPointsData = List.generate(7, (index) {
      final day = startWindow.add(Duration(days: index));
      final stat = stats[day];
      return {
        'day': weekdayLabels[day.weekday - 1],
        'points': stat?.points ?? 0.0,
      };
    });

    _consistencyHistory = List.generate(7, (index) {
      final day = startWindow.add(Duration(days: index));
      final stat = stats[day];
      final ratio = stat == null
          ? 0.0
          : (stat.total == 0
              ? (stat.completed > 0 ? 1.0 : 0.0)
              : (stat.completed / stat.total).clamp(0.0, 1.0));
      return {
        'day': weekdayLabels[day.weekday - 1],
        'consistency': ratio,
      };
    });

    final daysWithStats = stats.entries
        .where((entry) => entry.key.isAfter(startWindow.subtract(const Duration(days: 1))))
        .toList();

    final averagePoints = daysWithStats.isEmpty
        ? 0.0
        : totalPoints / daysWithStats.length;

    _weeklySummary = {
      'completedTasks': combinedCompletions,
      'totalTasks': totalTargets,
      'averagePoints': averagePoints,
      'successRate': successRate,
    };

    final monthlyData = <DateTime, DailyAnalytics>{};
    stats.forEach((date, stat) {
      if (date.year == now.year && date.month == now.month) {
        final ratio = stat.total == 0
            ? (stat.completed > 0 ? 1.0 : 0.0)
            : (stat.completed / stat.total).clamp(0.0, 1.0);
        monthlyData[date] = DailyAnalytics(
          date: date,
          pointsEarned: stat.points,
          tasksCompleted: stat.completed,
          totalTasks: stat.total == 0 ? stat.completed : stat.total,
          grade: _gradeFromRatio(ratio),
          isSuccessfulDay: ratio >= 0.6,
        );
      }
    });

    final successfulDays =
        monthlyData.values.where((d) => d.isSuccessfulDay).length;
    final totalDays = monthlyData.length;
    final monthlyAveragePoints = totalDays == 0
        ? 0.0
        : monthlyData.values.fold<double>(
              0.0, (sum, d) => sum + d.pointsEarned) /
            totalDays;
    final monthlySuccessRate =
        totalDays == 0 ? 0.0 : successfulDays / totalDays;

    _currentMonthlyAnalytics = totalDays == 0
        ? null
        : MonthlyAnalytics(
            year: now.year,
            month: now.month,
            successfulDays: successfulDays,
            totalDays: totalDays,
            averagePoints: monthlyAveragePoints,
            consistencyGrade: _gradeFromRatio(monthlySuccessRate),
            dailyData: monthlyData,
          );
  }

  DateTime _normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  int _calculateCurrentStreak(List<DateTime> dates) {
    if (dates.isEmpty) return 0;
    final today = _normalizeDate(DateTime.now());
    int streak = 0;
    for (int i = dates.length - 1; i >= 0; i--) {
      final expected = today.subtract(Duration(days: streak));
      if (dates[i] == expected) {
        streak++;
      } else if (dates[i].isBefore(expected)) {
        break;
      }
    }
    return streak;
  }

  int _calculateLongestStreak(List<DateTime> dates) {
    if (dates.isEmpty) return 0;
    int longest = 1;
    int current = 1;
    for (int i = 1; i < dates.length; i++) {
      final prev = dates[i - 1];
      final currentDate = dates[i];
      if (currentDate.difference(prev).inDays == 1) {
        current++;
      } else if (currentDate != prev) {
        current = 1;
      }
      if (current > longest) longest = current;
    }
    return longest;
  }

  String _gradeFromRatio(double ratio) {
    if (ratio >= 0.9) return 'A';
    if (ratio >= 0.8) return 'B';
    if (ratio >= 0.7) return 'C';
    if (ratio >= 0.6) return 'D';
    return 'F';
  }
}

class _DailyStats {
  int total = 0;
  int completed = 0;
  double points = 0.0;
}

