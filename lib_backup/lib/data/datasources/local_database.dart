import 'dart:convert';
import 'shared_prefs.dart';

class LocalDatabase {
  final SharedPrefs _sharedPrefs = SharedPrefs();

  // ADD THIS MISSING METHOD
  Future<void> remove(String key) async {
    await _sharedPrefs.remove(key);
  }

  // ... rest of your existing methods ...
  Future<List<Map<String, dynamic>>> getTasks() async {
    final tasks = await _sharedPrefs.getList('tasks') ?? [];
    return tasks.map<Map<String, dynamic>>((e) {
      if (e is Map<String, dynamic>) return e;
      if (e is String) {
        try {
          return Map<String, dynamic>.from(jsonDecode(e));
        } catch (_) {
          return {};
        }
      }
      return Map<String, dynamic>.from(e as Map);
    }).toList();
  }

  Future<void> saveTask(Map<String, dynamic> task) async {
    final tasks = await getTasks();
    // Check if task already exists (by id)
    final existingIndex = tasks.indexWhere((t) => t['id'] == task['id']);
    if (existingIndex != -1) {
      // Update existing task
      tasks[existingIndex] = task;
    } else {
      // Add new task
      tasks.add(task);
    }
    await _sharedPrefs.saveList('tasks', tasks);
  }

  Future<void> updateTask(String taskId, Map<String, dynamic> updatedTask) async {
    final tasks = await getTasks();
    final index = tasks.indexWhere((task) => task['id'] == taskId);
    if (index != -1) {
      tasks[index] = updatedTask;
      await _sharedPrefs.saveList('tasks', tasks);
    }
  }

  Future<void> deleteTask(String taskId) async {
    final tasks = await getTasks();
    tasks.removeWhere((task) => task['id'] == taskId);
    await _sharedPrefs.saveList('tasks', tasks);
  }

  Future<void> saveAnalytics(Map<String, dynamic> analytics) async {
    await _sharedPrefs.saveMap('analytics', analytics);
  }

  Future<Map<String, dynamic>> getAnalytics() async {
    return await _sharedPrefs.getMap('analytics') ?? {};
  }

  // Generic map helpers used by repositories
  Future<Map<String, dynamic>?> getMap(String key) async {
    return await _sharedPrefs.getMap(key);
  }

  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    await _sharedPrefs.saveMap(key, value);
  }

  // Generic list helpers
  Future<List<dynamic>?> getList(String key) async {
    return await _sharedPrefs.getList(key);
  }

  Future<void> saveList(String key, List<dynamic> value) async {
    await _sharedPrefs.saveList(key, value);
  }

  // Goals methods
  Future<List<Map<String, dynamic>>> getGoals() async {
    final goals = await _sharedPrefs.getList('goals') ?? [];
    return goals.map<Map<String, dynamic>>((e) {
      if (e is Map<String, dynamic>) return e;
      if (e is String) {
        try {
          return Map<String, dynamic>.from(jsonDecode(e));
        } catch (_) {
          return {};
        }
      }
      return Map<String, dynamic>.from(e as Map);
    }).toList();
  }

  Future<void> saveGoal(Map<String, dynamic> goal) async {
    final goals = await getGoals();
    goals.add(goal);
    await _sharedPrefs.saveList('goals', goals);
  }

  Future<void> updateGoal(String goalId, Map<String, dynamic> updatedGoal) async {
    final goals = await getGoals();
    final index = goals.indexWhere((goal) => goal['id'] == goalId);
    if (index != -1) {
      goals[index] = updatedGoal;
      await _sharedPrefs.saveList('goals', goals);
    }
  }

  Future<void> deleteGoal(String goalId) async {
    final goals = await getGoals();
    goals.removeWhere((goal) => goal['id'] == goalId);
    await _sharedPrefs.saveList('goals', goals);
  }
}