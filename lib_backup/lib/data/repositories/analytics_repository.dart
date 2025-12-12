import 'dart:developer';

import '../models/analytics_model.dart';
import '../datasources/local_database.dart';

class AnalyticsRepository {
    final LocalDatabase _localDatabase = LocalDatabase();

    Future<void> saveDailyAnalytics(DailyAnalytics analytics) async {
      try {
        final allAnalytics = await getMonthlyAnalytics(DateTime.now());
        allAnalytics.dailyData[analytics.date] = analytics;

        await _localDatabase.saveMap(
          'analytics_${analytics.date.year}_${analytics.date.month}',
          allAnalytics.toJson(),
        );
      } catch (e, st) {
        log('Error saving daily analytics: $e', error: e, stackTrace: st);
        rethrow;
      }
    }

    Future<MonthlyAnalytics> getMonthlyAnalytics(DateTime date) async {
      try {
        final data = await _localDatabase.getMap('analytics_${date.year}_${date.month}');
        return data != null
            ? MonthlyAnalytics.fromJson(data)
            : MonthlyAnalytics(
                year: date.year,
                month: date.month,
                successfulDays: 0,
                totalDays: 0,
                averagePoints: 0,
                consistencyGrade: 'F',
                dailyData: {},
              );
      } catch (e, st) {
        log('Error getting monthly analytics: $e', error: e, stackTrace: st);
        return MonthlyAnalytics(
          year: date.year,
          month: date.month,
          successfulDays: 0,
          totalDays: 0,
          averagePoints: 0,
          consistencyGrade: 'F',
          dailyData: {},
        );
      }
    }

    Future<List<MonthlyAnalytics>> getYearlyAnalytics(int year) async {
      final List<MonthlyAnalytics> analytics = [];

      for (int month = 1; month <= 12; month++) {
        final monthly = await getMonthlyAnalytics(DateTime(year, month));
        analytics.add(monthly);
      }

      return analytics;
    }

    Future<Map<String, dynamic>> getConsistencyData() async {
      try {
        final now = DateTime.now();
        final monthlyAnalytics = await getMonthlyAnalytics(now);

        final successfulDays = monthlyAnalytics.successfulDays;
        final totalDays = monthlyAnalytics.totalDays;
        final successRate = totalDays > 0 ? successfulDays / totalDays : 0;

        return {
          'successRate': successRate,
          'successfulDays': successfulDays,
          'totalDays': totalDays,
          'currentStreak': _calculateCurrentStreak(monthlyAnalytics.dailyData),
          'longestStreak': _calculateLongestStreak(monthlyAnalytics.dailyData),
        };
      } catch (e, st) {
        log('Error getting consistency data: $e', error: e, stackTrace: st);
        return {
          'successRate': 0,
          'successfulDays': 0,
          'totalDays': 0,
          'currentStreak': 0,
          'longestStreak': 0,
        };
      }
    }

    int _calculateCurrentStreak(Map<DateTime, DailyAnalytics> dailyData) {
      int streak = 0;
      final today = DateTime.now();

      for (int i = 0; i < 365; i++) {
        final date = today.subtract(Duration(days: i));
        final analytics = dailyData[date];

        if (analytics != null && analytics.isSuccessfulDay) {
          streak++;
        } else {
          break;
        }
      }

      return streak;
    }

    int _calculateLongestStreak(Map<DateTime, DailyAnalytics> dailyData) {
      int longestStreak = 0;
      int currentStreak = 0;

      final dates = dailyData.keys.toList()..sort();

      for (final date in dates) {
        final analytics = dailyData[date];
        if (analytics != null && analytics.isSuccessfulDay) {
          currentStreak++;
          longestStreak = currentStreak > longestStreak ? currentStreak : longestStreak;
        } else {
          currentStreak = 0;
        }
      }

      return longestStreak;
    }
  }