import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../data/models/goal_model.dart';
import '../../../data/repositories/goal_repository.dart';
import '../../../services/ai_service.dart';
import 'package:uuid/uuid.dart';

class GoalProvider with ChangeNotifier {
  final GoalRepository _repository = GoalRepository();
  final AIService _aiService = AIService();
  final Uuid _uuid = const Uuid();
  
  List<Goal> _goals = [];
  bool _isLoading = false;
  String? _aiAdvice;
  bool _isLoadingAI = false;

  List<Goal> get goals => _goals;
  bool get isLoading => _isLoading;
  String? get aiAdvice => _aiAdvice;
  bool get isLoadingAI => _isLoadingAI;

  GoalProvider() {
    loadGoals();
  }

  Future<void> loadGoals() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _goals = await _repository.getGoals();
    } catch (error) {
      log('Error loading goals: $error', error: error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addGoal(Goal goal) async {
    _goals.add(goal);
    await _repository.saveGoal(goal);
    notifyListeners();
  }

  Future<void> updateGoal(Goal goal) async {
    final index = _goals.indexWhere((g) => g.id == goal.id);
    if (index != -1) {
      _goals[index] = goal;
      await _repository.updateGoal(goal);
      notifyListeners();
    }
  }

  Future<void> deleteGoal(String goalId) async {
    _goals.removeWhere((goal) => goal.id == goalId);
    await _repository.deleteGoal(goalId);
    notifyListeners();
  }

  Future<void> addProgressEntry(String goalId, ProgressEntry entry) async {
    final goal = _goals.firstWhere((g) => g.id == goalId);
    final updatedEntries = List<ProgressEntry>.from(goal.progressEntries)..add(entry);
    final newProgress = (goal.progress + entry.progressChange).clamp(0.0, 100.0);
    final isCompleted = newProgress >= 100.0;
    
    final updatedGoal = goal.copyWith(
      progress: newProgress,
      progressEntries: updatedEntries,
      isCompleted: isCompleted,
      completedAt: isCompleted ? DateTime.now() : goal.completedAt,
    );
    
    await updateGoal(updatedGoal);
  }

  Future<void> getGoalAdvice(String goalId) async {
    _isLoadingAI = true;
    notifyListeners();

    try {
      final goal = _goals.firstWhere((g) => g.id == goalId);
      
      _aiAdvice = await _aiService.generateGoalAdvice(
        goalTitle: goal.title,
        goalDescription: goal.description,
        currentProgress: goal.progress,
        progressEntries: goal.progressEntries.map((e) => {
          'date': e.date.toIso8601String(),
          'note': e.note,
          'progressChange': e.progressChange,
        }).toList(),
        targetDate: goal.targetDate,
      );
    } catch (e) {
      log('Error getting goal advice: $e', error: e);
      _aiAdvice = 'أنا هنا لمساعدتك في تحقيق هدفك. استمر في العمل!';
    } finally {
      _isLoadingAI = false;
      notifyListeners();
    }
  }

  List<Goal> getActiveGoals() {
    return _goals.where((g) => !g.isCompleted).toList();
  }

  List<Goal> getCompletedGoals() {
    return _goals.where((g) => g.isCompleted).toList();
  }
}

