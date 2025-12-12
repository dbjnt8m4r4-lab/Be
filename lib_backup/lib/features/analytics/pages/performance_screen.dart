import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/analytics_provider.dart';
import '../../../core/constants/color_constants.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/grade_widget.dart';
import '../widgets/consistency_graph.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PerformanceScreenState createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  String _selectedTimeRange = 'weekly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.userPerformance),
      ),
      body: Consumer<AnalyticsProvider>(
        builder: (context, analyticsProvider, child) {
          if (analyticsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final consistencyData = analyticsProvider.getConsistencyData();
          final weeklySummary = analyticsProvider.getWeeklySummary();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Time Range Selector
              _buildTimeRangeSelector(),
              
              const SizedBox(height: 24),
              
              // Overall Grade
              GradeWidget(
                grade: _calculateOverallGrade(weeklySummary['successRate']),
                title: 'Overall Rating',
                size: 120,
              ),
              
              const SizedBox(height: 24),
              
              // Consistency Graph
              ConsistencyGraph(
                consistencyData: consistencyData,
                consistencyHistory: analyticsProvider.getConsistencyHistory(),
              ),
              
              const SizedBox(height: 24),
              
              // Performance Metrics
              _buildPerformanceMetrics(weeklySummary, consistencyData),
              
              const SizedBox(height: 24),
              
              // Improvement Tips
              _buildImprovementTips(weeklySummary),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Time Range',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _buildTimeRangeChip('Weekly', 'weekly'),
                _buildTimeRangeChip('Monthly', 'monthly'),
                _buildTimeRangeChip('Yearly', 'yearly'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangeChip(String label, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedTimeRange == value,
      onSelected: (selected) {
        setState(() {
          _selectedTimeRange = value;
        });
      },
    );
  }

  Widget _buildPerformanceMetrics(Map<String, dynamic> weeklySummary, Map<String, dynamic> consistencyData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Metrics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildMetricCard(
                  'Task Completion Rate',
                  '${((weeklySummary['completedTasks'] / weeklySummary['totalTasks']) * 100).toStringAsFixed(1)}%',
                  Icons.task,
                  ColorConstants.secondaryColor,
                ),
                _buildMetricCard(
                  'Average Daily Points',
                  weeklySummary['averagePoints'].toStringAsFixed(1),
                  Icons.assessment,
                  ColorConstants.accentDark,
                ),
                _buildMetricCard(
                  'Current Streak',
                  AppLocalizations.of(context)!.daysCount(consistencyData['currentStreak']),
                  Icons.local_fire_department,
                  ColorConstants.accentMid,
                ),
                _buildMetricCard(
                  'Success Rate',
                  '${(weeklySummary['successRate'] * 100).toStringAsFixed(1)}%',
                  Icons.trending_up,
                  ColorConstants.accentMid,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImprovementTips(Map<String, dynamic> weeklySummary) {
    final successRate = weeklySummary['successRate'];
    List<String> tips = [];

    if (successRate < 0.5) {
      tips = [
        'Try breaking large tasks into smaller ones',
        'Set your priorities better',
        'Use reminders to avoid forgetting tasks',
      ];
    } else if (successRate < 0.8) {
      tips = [
        'Keep focusing on important tasks',
        'Try improving task time allocation',
        'Make your routine more consistent',
      ];
    } else {
      tips = [
        'Great! Keep up this excellent performance',
        'Try helping others improve their performance',
        'Set new goals to challenge yourself',
      ];
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Improvement Tips',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...tips.map((tip) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_outline, color: ColorConstants.accentMid, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tip,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  String _calculateOverallGrade(double successRate) {
    final percentage = successRate * 100;
    
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B+';
    if (percentage >= 60) return 'B';
    if (percentage >= 50) return 'C+';
    if (percentage >= 40) return 'C';
    if (percentage >= 30) return 'D';
    return 'F';
  }
}