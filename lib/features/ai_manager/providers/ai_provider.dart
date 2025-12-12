import 'package:flutter/material.dart';
import '../../../services/ai_service.dart';

class AIProvider with ChangeNotifier {
  final AIService _aiService = AIService();
  
  String _advice = '';
  bool _isLoading = false;
  String? _error;
  List<String> _suggestions = [];

  String get advice => _advice;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<String> get suggestions => _suggestions;

  Future<void> generatePerformanceAdvice({
    required List<Map<String, dynamic>> dailyData,
    required Map<String, dynamic> userHabits,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _advice = await _aiService.analyzePerformance(
        dailyData: dailyData,
        userHabits: userHabits,
      );
    } catch (e) {
      _error = 'فشل في توليد النصيحة';
      _advice = 'أنا هنا لمساعدتك في تحسين إنتاجيتك. استمر في العمل على مهامك!';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> generateHabitAdvice({
    required String habitName,
    required int successRate,
    required int currentStreak,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _advice = await _aiService.generateHabitAdvice(
        habitName: habitName,
        successRate: successRate,
        currentStreak: currentStreak,
      );
    } catch (e) {
      _error = 'فشل في توليد نصيحة العادة';
      _advice = 'حافظ على استمرارية هذه العادة. كل يوم يهم!';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadQuickTaskSuggestions() async {
    try {
      _suggestions = await _aiService.suggestQuickTasks();
      notifyListeners();
    } catch (e) {
      _suggestions = [
        'ممارسة الرياضة لمدة 15 دقيقة',
        'قراءة 10 صفحات من كتاب',
        'ترتيب المكتب',
      ];
    }
  }

  void clearAdvice() {
    _advice = '';
    notifyListeners();
  }
}