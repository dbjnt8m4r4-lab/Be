import '../../data/models/task_model.dart';
import '../constants/app_constants.dart';

class PointsCalculator {
  static Map<String, double> calculatePoints(List<Task> tasks) {
    if (tasks.isEmpty) return {};
    
    double totalWeight = 0;
    for (var task in tasks) {
      totalWeight += Priority.getWeight(task.priority);
    }
    
    Map<String, double> pointsMap = {};
    for (var task in tasks) {
      double taskWeight = Priority.getWeight(task.priority);
      double points = (taskWeight / totalWeight) * AppConstants.totalDailyPoints;
      pointsMap[task.id] = double.parse(points.toStringAsFixed(2));
    }
    
    return pointsMap;
  }
  
  static double calculateDailyPoints(List<Task> completedTasks) {
    double totalPoints = 0;
    for (var task in completedTasks) {
      totalPoints += task.assignedPoints;
    }
    return totalPoints;
  }
  
  static bool isDaySuccessful(double points) {
    return points >= AppConstants.successThreshold;
  }

  static String calculateGrade(double points) {
    if (points >= 100) return 'A+';
    if (points >= 90) return 'A';
    if (points >= 80) return 'B';
    if (points >= 70) return 'C';
    if (points >= 60) return 'D';
    if (points >= 50) return 'E';
    return 'F';
  }
}