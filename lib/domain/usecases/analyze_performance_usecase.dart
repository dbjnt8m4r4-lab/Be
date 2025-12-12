import '../../data/models/analytics_model.dart';
import '../../core/utils/grade_calculator.dart';

class AnalyzePerformanceUseCase {
  DailyAnalytics analyzeDailyPerformance({
    required double pointsEarned,
    required int tasksCompleted,
    required int totalTasks,
  }) {
    final grade = GradeCalculator.calculateGrade(pointsEarned);
    final isSuccessfulDay = pointsEarned >= 50;

    return DailyAnalytics(
      date: DateTime.now(),
      pointsEarned: pointsEarned,
      tasksCompleted: tasksCompleted,
      totalTasks: totalTasks,
      grade: grade,
      isSuccessfulDay: isSuccessfulDay,
    );
  }

  MonthlyAnalytics analyzeMonthlyPerformance(List<DailyAnalytics> dailyData) {
    final successfulDays = dailyData.where((day) => day.isSuccessfulDay).length;
    final totalDays = dailyData.length;
    final averagePoints = dailyData
            .map((day) => day.pointsEarned)
            .reduce((a, b) => a + b) /
        totalDays;
    final successRate = successfulDays / totalDays;
    final consistencyGrade = GradeCalculator.calculateMonthlyGrade(successRate);

    final dailyDataMap = {
      for (var day in dailyData) day.date: day
    };

    return MonthlyAnalytics(
      year: DateTime.now().year,
      month: DateTime.now().month,
      successfulDays: successfulDays,
      totalDays: totalDays,
      averagePoints: averagePoints,
      consistencyGrade: consistencyGrade,
      dailyData: dailyDataMap,
    );
  }
}