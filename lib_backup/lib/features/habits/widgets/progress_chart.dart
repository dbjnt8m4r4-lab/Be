import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../l10n/app_localizations.dart';

/// Simple, dependency-free progress chart replacement.
/// Expects `progressData` as a list of maps with keys: 'date' (DateTime) and 'completed' (bool).
class ProgressChart extends StatelessWidget {
  final List<Map<String, dynamic>> progressData;
  final String habitName;

  const ProgressChart({
    super.key,
    required this.progressData,
    required this.habitName,
  });

  @override
  Widget build(BuildContext context) {
    final completedDays = progressData.where((d) => d['completed'] == true).length;
    final totalDays = progressData.length;
    final completionRate = totalDays > 0 ? completedDays / totalDays : 0.0;

    final loc = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.habitProgressHeading(habitName),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Simple progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: completionRate,
                minHeight: 12,
                backgroundColor: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white.withAlpha((0.15 * 255).round())
                    : Colors.black.withAlpha((0.15 * 255).round()),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Mini day-by-day indicator row
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: progressData.length,
                separatorBuilder: (_, __) => const SizedBox(width: 6),
                itemBuilder: (context, index) {
                  final item = progressData[index];
                  final done = item['completed'] == true;
                  return Container(
                    width: 22,
                    height: 40,
                    decoration: BoxDecoration(
                      color: done ? ColorConstants.accentDark : ColorConstants.accentLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(fontSize: 11, color: ColorConstants.surfaceColor),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(context, loc.completedDaysLabel, '$completedDays'),
                _buildStatItem(context, loc.totalDaysLabel, '$totalDays'),
                _buildStatItem(context, loc.successRateLabel, '${(completionRate * 100).toStringAsFixed(0)}%'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
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
// End of file - only the lightweight ProgressChart is kept.