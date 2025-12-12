import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color_constants.dart';
import '../providers/ai_provider.dart';
import '../widgets/advice_card.dart';
import '../widgets/suggestion_list.dart';
import '../widgets/motivation_message.dart';

class AIAdviceScreen extends StatefulWidget {
  const AIAdviceScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AIAdviceScreenState createState() => _AIAdviceScreenState();
}

class _AIAdviceScreenState extends State<AIAdviceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAIAdvice();
    });
  }

  Future<void> _loadAIAdvice() async {
    final aiProvider = Provider.of<AIProvider>(context, listen: false);

    // Load sample data for demonstration
    final sampleData = {
      'dailyData': [
        {
          'date': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
          'points': 85,
          'tasksCompleted': 4,
          'totalTasks': 5,
          'grade': 'B+',
        },
        {
          'date': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
          'points': 92,
          'tasksCompleted': 5,
          'totalTasks': 5,
          'grade': 'A-',
        },
      ],
      'userHabits': {
        'exercise': 0.8,
        'reading': 0.6,
        'planning': 0.9,
      },
    };

    final rawDaily = sampleData['dailyData'];
    final List<Map<String, dynamic>> dailyData = (rawDaily is List)
        ? rawDaily.map<Map<String, dynamic>>((e) {
            if (e is Map<String, dynamic>) return e;
            if (e is Map) return Map<String, dynamic>.from(e);
            return {};
          }).toList()
        : [];

    final rawHabits = sampleData['userHabits'];
    final Map<String, dynamic> userHabits = rawHabits is Map
        ? Map<String, dynamic>.from(rawHabits)
        : {};

    await aiProvider.generatePerformanceAdvice(
      dailyData: dailyData,
      userHabits: userHabits,
    );

    await aiProvider.loadQuickTaskSuggestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kyronos — مدير الانضباط الذكي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAIAdvice,
          ),
        ],
      ),
      body: Consumer<AIProvider>(
        builder: (context, aiProvider, child) {
          final hasError = aiProvider.error != null;
          final isLoading = aiProvider.isLoading;

          return RefreshIndicator(
            onRefresh: () async {
              await _loadAIAdvice();
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Motivation Message from Kyronos
                const MotivationMessage(),
                const SizedBox(height: 24),
                // AI Advice
                if (aiProvider.isLoading)
                  _buildLoadingAdvice()
                else
                  AdviceCard(advice: aiProvider.advice),
                
                const SizedBox(height: 24),
                
                // Quick Suggestions
                SuggestionList(suggestions: aiProvider.suggestions),
                
                const SizedBox(height: 24),
                
                // Additional Features
                _buildAdditionalFeatures(),
                
                if (aiProvider.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      aiProvider.error!,
                      style: const TextStyle(color: ColorConstants.accentLight),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingAdvice() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'جاري تحليل أدائك وتوليد النصائح...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalFeatures() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ميزات إضافية',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFeatureButton(
              'تحليل العادات',
              Icons.psychology,
              () {
                // Navigate to habit analysis
              },
            ),
            _buildFeatureButton(
              'توصيات التحسين',
              Icons.auto_awesome,
              () {
                // Navigate to improvement recommendations
              },
            ),
            _buildFeatureButton(
              'توقعات الأداء',
              Icons.trending_up,
              () {
                // Navigate to performance predictions
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: ColorConstants.secondaryColor),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}