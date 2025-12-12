import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/analytics_provider.dart';
import '../widgets/stats_grid.dart';
import '../widgets/points_chart.dart';
import '../widgets/consistency_graph.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.analytics ?? 'Analytics'),
      ),
      body: Consumer<AnalyticsProvider>(
        builder: (context, analyticsProvider, child) {
          if (analyticsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final weeklySummary = analyticsProvider.getWeeklySummary();
          final consistencyData = analyticsProvider.getConsistencyData();
          final dailyPointsData = analyticsProvider.getDailyPointsData();
          final consistencyHistory = analyticsProvider.getConsistencyHistory();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Stats Grid
              StatsGrid(
                averagePoints: weeklySummary['averagePoints'] ?? 0,
                successRate: weeklySummary['successRate'] ?? 0,
                currentStreak: consistencyData['currentStreak'] ?? 0,
                longestStreak: consistencyData['longestStreak'] ?? 0,
              ),

              const SizedBox(height: 24),

              // Points Chart
              PointsChart(
                dailyPointsData: dailyPointsData,
              ),

              const SizedBox(height: 24),

              // Consistency Graph
              ConsistencyGraph(
                consistencyData: consistencyData,
                consistencyHistory: consistencyHistory,
              ),

              const SizedBox(height: 24),

              // Weekly Summary
              _buildWeeklySummary(context, weeklySummary),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWeeklySummary(BuildContext context, Map<String, dynamic> weeklySummary) {
    final loc = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.weeklySummaryTitle ?? 'Weekly Summary',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  context,
                  loc.weeklyTasksCompleted ?? 'Tasks Completed',
                  '${weeklySummary['completedTasks'] ?? 0}/${weeklySummary['totalTasks'] ?? 0}',
                ),
                _buildSummaryItem(
                  context,
                  loc.weeklySuccessRate ?? 'Success Rate',
                  '${((weeklySummary['successRate'] ?? 0) * 100).toStringAsFixed(1)}%',
                ),
                _buildSummaryItem(
                  context,
                  loc.weeklyAveragePoints ?? 'Avg Points',
                  (weeklySummary['averagePoints'] ?? 0).toStringAsFixed(1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}