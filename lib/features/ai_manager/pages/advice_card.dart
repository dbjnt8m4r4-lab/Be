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
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final aiProvider = Provider.of<AIProvider>(context, listen: false);

    // Example data - in real app, use actual user data
    final userData = {
      'dailyData': [
        {
          'date': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
          'points': 85,
          'tasksCompleted': 4,
          'totalTasks': 5,
          'grade': 'B+',
        }
      ],
      'userHabits': {
        'exercise': 0.8,
        'reading': 0.6,
      },
    };

    // Safely cast incoming dynamic data to the expected types
    final rawDaily = userData['dailyData'];
    final List<Map<String, dynamic>> dailyData = (rawDaily is List)
        ? rawDaily.map<Map<String, dynamic>>((e) {
            if (e is Map<String, dynamic>) return e;
            if (e is Map) return Map<String, dynamic>.from(e);
            return {};
          }).toList()
        : [];

    final rawHabits = userData['userHabits'];
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
        title: const Text('مدير الذكاء الاصطناعي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: Consumer<AIProvider>(
        builder: (context, aiProvider, child) {
          if (aiProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              await _loadData();
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const MotivationMessage(),
                
                const SizedBox(height: 24),
                
                AdviceCard(advice: aiProvider.advice),
                
                const SizedBox(height: 24),
                
                SuggestionList(suggestions: aiProvider.suggestions),
                
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
}