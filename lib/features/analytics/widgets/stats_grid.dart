import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../l10n/app_localizations.dart';

class StatsGrid extends StatelessWidget {
  final double averagePoints;
  final double successRate;
  final int currentStreak;
  final int longestStreak;

  const StatsGrid({super.key, 
    required this.averagePoints,
    required this.successRate,
    required this.currentStreak,
    required this.longestStreak,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildStatCard(
          context,
          loc.averagePointsLabel,
          averagePoints.toStringAsFixed(1),
          Icons.assessment,
          ColorConstants.secondaryColor,
        ),
        _buildStatCard(
          context,
          loc.successRateLabel,
          '${(successRate * 100).toStringAsFixed(1)}%',
          Icons.trending_up,
          ColorConstants.accentDark,
        ),
        _buildStatCard(
          context,
          loc.currentStreakLabel,
          loc.daysCount(currentStreak),
          Icons.local_fire_department,
          ColorConstants.accentMid,
        ),
        _buildStatCard(
          context,
          loc.longestStreakLabel,
          loc.daysCount(longestStreak),
          Icons.emoji_events,
          ColorConstants.accentMid,
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}