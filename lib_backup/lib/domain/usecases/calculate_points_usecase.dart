import '../../data/models/task_model.dart';
import '../../core/utils/points_calculator.dart';

class CalculatePointsUseCase {
  Map<String, double> execute(List<Task> tasks) {
    return PointsCalculator.calculatePoints(tasks);
  }

  double calculateDailyPoints(List<Task> completedTasks) {
    return PointsCalculator.calculateDailyPoints(completedTasks);
  }

  bool isDaySuccessful(double points) {
    return PointsCalculator.isDaySuccessful(points);
  }
}