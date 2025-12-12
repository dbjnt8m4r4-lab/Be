import 'dart:developer';
import '../models/goal_model.dart';
import '../datasources/local_database.dart';

class GoalRepository {
  final LocalDatabase _localDatabase = LocalDatabase();

  Future<List<Goal>> getGoals() async {
    try {
      final goalsData = await _localDatabase.getGoals();
      return goalsData.map((data) => Goal.fromJson(data)).toList();
    } catch (e) {
      log('Error getting goals: $e', error: e);
      return [];
    }
  }

  Future<void> saveGoal(Goal goal) async {
    try {
      await _localDatabase.saveGoal(goal.toJson());
    } catch (e) {
      log('Error saving goal: $e', error: e);
      rethrow;
    }
  }

  Future<void> deleteGoal(String goalId) async {
    try {
      await _localDatabase.deleteGoal(goalId);
    } catch (e) {
      log('Error deleting goal: $e', error: e);
      rethrow;
    }
  }

  Future<void> updateGoal(Goal goal) async {
    try {
      await _localDatabase.updateGoal(goal.id, goal.toJson());
    } catch (e) {
      log('Error updating goal: $e', error: e);
      rethrow;
    }
  }
}

