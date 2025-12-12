import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../l10n/app_localizations.dart';

class PointsChart extends StatelessWidget {
  final List<Map<String, dynamic>> dailyPointsData;

  const PointsChart({super.key, required this.dailyPointsData});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lineColor = isDark ? Colors.white : Colors.black;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.dailyPointsLabel,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
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
                          if (index >= 0 && index < dailyPointsData.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                dailyPointsData[index]['day'].toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                        interval: 1,
                      ),
                    ),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: dailyPointsData.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), (e.value['points'] as double));
                      }).toList(),
                      isCurved: true,
                      preventCurveOverShooting: true,
                      color: lineColor,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: lineColor.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}