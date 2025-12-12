import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../l10n/app_localizations.dart';

class ConsistencyGraph extends StatelessWidget {
  final Map<String, dynamic> consistencyData;
  final List<Map<String, dynamic>> consistencyHistory;

  const ConsistencyGraph({
    super.key, 
    required this.consistencyData,
    required this.consistencyHistory,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final successRate = consistencyData['successRate'] ?? 0;
    final currentStreak = consistencyData['currentStreak'] ?? 0;
    final longestStreak = consistencyData['longestStreak'] ?? 0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lineColor = isDark ? Colors.orange : Colors.blue;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.consistencyTitle ?? 'Consistency Trend',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Streak Information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStreakInfo(context, 'Current Streak', '$currentStreak days', Icons.local_fire_department),
                _buildStreakInfo(context, 'Longest Streak', '$longestStreak days', Icons.emoji_events),
                _buildStreakInfo(context, 'Success Rate', '${(successRate * 100).toStringAsFixed(1)}%', Icons.trending_up),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Curved Line Chart
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < consistencyHistory.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                consistencyHistory[index]['day'].toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark ? Colors.white70 : Colors.black54,
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                        interval: 1,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${(value * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 10,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          );
                        },
                        interval: 0.2,
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: isDark ? Colors.white24 : Colors.grey.shade300,
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: consistencyHistory.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), (e.value['consistency'] as double));
                      }).toList(),
                      isCurved: true,
                      curveSmoothness: 0.3,
                      preventCurveOverShooting: true,
                      color: lineColor,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            lineColor.withOpacity(0.3),
                            lineColor.withOpacity(0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                  minY: 0,
                  maxY: 1,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            Text(
              'Consistency trend over the past week',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakInfo(BuildContext context, String title, String value, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      children: [
        Icon(icon, size: 24, color: isDark ? Colors.orange : Colors.blue),
        const SizedBox(height: 4),
        Text(
          value, 
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title, 
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}