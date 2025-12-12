import 'dart:developer';
import '../models/task_model.dart';
import '../datasources/local_database.dart';

class TaskRepository {
  final LocalDatabase _localDatabase = LocalDatabase();

  Future<List<Task>> getTasks() async {
    try {
      final tasksData = await _localDatabase.getTasks();
      return tasksData.map((data) => Task.fromJson(data)).toList();
    } catch (e) {
      log('Error getting tasks: $e', error: e);
      return [];
    }
  }

  Future<void> saveTask(Task task) async {
    try {
      await _localDatabase.saveTask(task.toJson());
    } catch (e) {
      log('Error saving task: $e', error: e);
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _localDatabase.deleteTask(taskId);
    } catch (e) {
      log('Error deleting task: $e', error: e);
      rethrow;
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _localDatabase.updateTask(task.id, task.toJson());
    } catch (e) {
      log('Error updating task: $e', error: e);
      rethrow;
    }
  }
}