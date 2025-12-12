import '../../services/ai_service.dart';

class GenerateAdviceUseCase {
  final AIService _aiService = AIService();

  Future<String> generatePerformanceAdvice({
    required List<Map<String, dynamic>> dailyData,
    required Map<String, dynamic> userHabits,
  }) async {
    return await _aiService.analyzePerformance(
      dailyData: dailyData,
      userHabits: userHabits,
    );
  }

  Future<String> generateHabitAdvice({
    required String habitName,
    required int successRate,
    required int currentStreak,
  }) async {
    return await _aiService.generateHabitAdvice(
      habitName: habitName,
      successRate: successRate,
      currentStreak: currentStreak,
    );
  }

  Future<List<String>> getQuickTaskSuggestions() async {
    return await _aiService.suggestQuickTasks();
  }
}