import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static final AIService _instance = AIService._internal();
  factory AIService() => _instance;
  AIService._internal();

  static const String _apiKey = 'YOUR_AI_API_KEY';
  static const String _baseUrl = 'https://api.openai.com/v1';

  Future<String> analyzePerformance({
    required List<Map<String, dynamic>> dailyData,
    required Map<String, dynamic> userHabits,
  }) async {
    try {
      final prompt = '''
      You are Kyronos, a disciplined yet encouraging AI mentor.
      Analyze this user's productivity data and provide personalized advice:
      
      Daily Performance Data: $dailyData
      User Habits: $userHabits
      
      Please provide (as Kyronos):
      1. Key insights about their productivity patterns
      2. Specific recommendations for improvement
      3. Motivation message based on their performance
      
      Respond in Arabic and speak in first person as Kyronos.
      ''';

      final response = await http.post(
        Uri.parse('$_baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'max_tokens': 500,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        return 'أنا هنا لمساعدتك في تحسين إنتاجيتك. استمر في العمل على مهامك!';
      }
    } catch (e) {
      return 'استمر في العمل الجاد! يمكنك تحقيق أهدافك بالالتزام.';
    }
  }

  Future<String> generateHabitAdvice({
    required String habitName,
    required int successRate,
    required int currentStreak,
  }) async {
    try {
      final prompt = '''
      You are Kyronos, a disciplined yet encouraging AI mentor.
      Provide advice for improving the habit "$habitName".
      
      Success rate: $successRate%
      Current streak: $currentStreak days
      
      Give practical tips in Arabic to improve consistency and speak in first person as Kyronos.
      ''';

      final response = await http.post(
        Uri.parse('$_baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'max_tokens': 300,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        return 'حافظ على استمرارية هذه العادة. كل يوم يهم!';
      }
    } catch (e) {
      return 'استمر في بناء هذه العادة الجيدة. أنت على الطريق الصحيح!';
    }
  }

  Future<List<String>> suggestQuickTasks() async {
    // Mock data for demonstration
    return [
      'ممارسة الرياضة لمدة 15 دقيقة',
      'قراءة 10 صفحات من كتاب',
      'ترتيب المكتب',
      'التخطيط لليوم التالي',
      'تعلم شيء جديد لمدة 20 دقيقة',
      'ممارسة التأمل لمدة 10 دقائق',
      'كتابة ثلاثة أشياء أنت ممتن لها',
    ];
  }

  Future<String> generateGoalAdvice({
    required String goalTitle,
    required String goalDescription,
    required double currentProgress,
    required List<dynamic> progressEntries,
    DateTime? targetDate,
  }) async {
    try {
      final progressEntriesText = progressEntries.isEmpty
          ? 'لا توجد إدخالات تقدم حتى الآن'
          : progressEntries.map((e) => '${e['date']}: ${e['note']}').join('\n');

      final targetDateText = targetDate != null
          ? 'تاريخ الهدف: ${targetDate.toIso8601String().split('T')[0]}'
          : 'لا يوجد تاريخ محدد';

      final prompt = '''
      You are Kyronos, a disciplined yet encouraging AI mentor.
      Help the user achieve their goal: "$goalTitle"
      
      Description: $goalDescription
      Current Progress: ${currentProgress.toStringAsFixed(1)}%
      $targetDateText
      
      Progress History:
      $progressEntriesText
      
      Please provide (as Kyronos):
      1. Motivation and encouragement based on current progress
      2. Specific actionable steps to move forward
      3. Problem-solving suggestions if progress is slow
      4. Tips to stay motivated and on track
      
      Respond in Arabic and speak in first person as Kyronos. Be encouraging but realistic.
      ''';

      final response = await http.post(
        Uri.parse('$_baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'max_tokens': 500,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        return 'أنا هنا لمساعدتك في تحقيق هدفك. استمر في العمل والالتزام!';
      }
    } catch (e) {
      return 'استمر في العمل الجاد! يمكنك تحقيق أهدافك بالالتزام والتفاني.';
    }
  }
}