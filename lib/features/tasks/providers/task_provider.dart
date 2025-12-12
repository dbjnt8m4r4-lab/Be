import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/task_model.dart';
import '../../../data/repositories/task_repository.dart';
import '../../../core/utils/points_calculator.dart';
import '../../../services/user_progress_service.dart';
import '../../../services/notification_service.dart';
import '../../../services/achievement_service.dart';
import '../../../services/challenge_service.dart';
import '../../../core/widgets/achievement_unlock_dialog.dart';

class TaskProvider with ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  final UserProgressService _progressService = UserProgressService();
  final NotificationService _notificationService = NotificationService();
  final AchievementService _achievementService = AchievementService();
  final ChallengeService _challengeService = ChallengeService();
  List<Task> _tasks = [];
  bool _isLoading = false;
  BuildContext? _context;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _tasks = await _repository.getTasks();
      _distributePoints();
    } catch (error) {
      log('Error loading tasks: $error', error: error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Task> getFilteredTasks(String filter) {
    switch (filter) {
      case 'high':
        return _tasks.where((task) => task.priority == Priority.high).toList();
      case 'normal':
        return _tasks.where((task) => task.priority == Priority.normal).toList();
      case 'low':
        return _tasks.where((task) => task.priority == Priority.low).toList();
      case 'completed':
        return _tasks.where((task) => task.isCompleted).toList();
      case 'pending':
        return _tasks.where((task) => !task.isCompleted).toList();
      default:
        return _tasks;
    }
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    _distributePoints();
    await _repository.saveTask(task);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      _distributePoints();
      await _repository.saveTask(task);
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
    _distributePoints();
    await _repository.deleteTask(taskId);
    notifyListeners();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  Future<void> toggleTaskCompletion(String taskId) async {
    final task = _tasks.firstWhere((t) => t.id == taskId);
    final wasCompleted = task.isCompleted;
    
    // If it's already completed, uncomplete it
    if (wasCompleted) {
      final updatedTask = task.copyWith(
        isCompleted: false,
        completedAt: null,
        completedCount: 0,
      );
      await updateTask(updatedTask);
      return;
    }

    Task updatedTask;
    bool shouldAwardPoints = true;

    if (task.repetition != null && task.repetition!.type == RepetitionType.multiplePerDay) {
      final newCount = task.completedCount + 1;
      final target = task.repetition!.targetCount;
      
      if (newCount < target) {
        updatedTask = task.copyWith(completedCount: newCount);
        shouldAwardPoints = false;
      } else {
        updatedTask = task.copyWith(
          completedCount: newCount,
          isCompleted: true,
          completedAt: DateTime.now(),
        );
      }
    } else {
      updatedTask = task.copyWith(
        isCompleted: true,
        completedAt: DateTime.now(),
      );
    }

    await updateTask(updatedTask);

    // Award points and handle achievements
    if (shouldAwardPoints && updatedTask.isCompleted) {
      await _handleTaskCompletion(updatedTask);
    }
  }

  Future<void> _handleTaskCompletion(Task completedTask) async {
    final pointsEarned = completedTask.assignedPoints.toInt();
    await _progressService.updateUserPoints(pointsEarned);
    
    await _progressService.updateStreak();
    
    final completedTasks = _tasks.where((t) => t.isCompleted).length;
    final streak = await _progressService.getUserStreak();
    final dailyPoints = getTodayPoints();
    
    final unlocked = await _achievementService.checkAchievements(
      tasksCompleted: completedTasks,
      currentStreak: streak,
      pointsEarned: dailyPoints,
      taskCompletedAt: completedTask.completedAt,
    );
    
    await _challengeService.updateChallengeProgress('daily_tasks_5', 1);
    await _challengeService.updateChallengeProgress('weekly_tasks_30', 1);
    
    // Show achievement unlock dialog if any were unlocked
    if (_context != null && unlocked) {
      final lastUnlockedId = await _achievementService.getLastUnlockedAchievementId();
      
      if (lastUnlockedId != null) {
        final allAchievements = await _achievementService.getAllAchievements();
        final achievement = allAchievements.firstWhere(
          (a) => a.id == lastUnlockedId,
          orElse: () => allAchievements.first,
        );
        
        if (_context!.mounted) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (_context != null && _context!.mounted) {
              showDialog(
                context: _context!,
                builder: (context) => AchievementUnlockDialog(achievement: achievement),
                barrierDismissible: true,
              );
            }
          });
        }
      }
    }
    
    notifyListeners();
  }

  void _distributePoints() {
    final pointsMap = PointsCalculator.calculatePoints(_tasks);
    
    for (var task in _tasks) {
      final points = pointsMap[task.id] ?? 0;
      if (task.assignedPoints != points) {
        final index = _tasks.indexWhere((t) => t.id == task.id);
        _tasks[index] = task.copyWith(assignedPoints: points);
      }
    }
  }

  List<Task> getTodayCompletedTasks() {
    final now = DateTime.now();
    return _tasks.where((task) {
      return task.isCompleted && 
             task.completedAt != null &&
             DateUtils.isSameDay(task.completedAt, now);
    }).toList();
  }

  double getTodayPoints() {
    return PointsCalculator.calculateDailyPoints(getTodayCompletedTasks());
  }
}