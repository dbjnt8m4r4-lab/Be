import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../l10n/app_localizations.dart';

class StreakCounter extends StatelessWidget {
  final int currentStreak;
  final int longestStreak;
  final int targetDays;

  const StreakCounter({super.key, 
    required this.currentStreak,
    required this.longestStreak,
    required this.targetDays,
  });

  @override
  Widget build(BuildContext context) {
    final progress = targetDays > 0 ? currentStreak / targetDays : 0.0;
    final isOnTrack = progress >= 0.7;

    final loc = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              loc.streakCounterTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Current Streak
            _buildStreakCircle(
              loc,
              currentStreak,
              loc.currentStreakLabel,
              isOnTrack ? ColorConstants.accentDark : ColorConstants.accentMid,
            ),
            
            const SizedBox(height: 24),
            
            // Progress towards goal
            _buildProgressSection(context, loc, progress, isOnTrack),
            
            const SizedBox(height: 16),
            
            // Additional stats
            _buildAdditionalStats(context, loc),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCircle(AppLocalizations loc, int streak, String label, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: color.withAlpha((0.1 * 255).round()),
                shape: BoxShape.circle,
                border: Border.all(
                  color: color,
                  width: 4,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  streak.toString(),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  loc.dayUnitLabel,
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection(BuildContext context, AppLocalizations loc, double progress, bool isOnTrack) {
    return Column(
      children: [
        Text(
          loc.progressTowardsGoal,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: ColorConstants.accentLight.withAlpha((0.06 * 255).round()),
          valueColor: AlwaysStoppedAnimation<Color>(
            isOnTrack ? ColorConstants.accentDark : ColorConstants.accentMid,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          loc.streakGoalProgress(currentStreak, targetDays),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '${(progress * 100).toStringAsFixed(1)}%',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildAdditionalStats(BuildContext context, AppLocalizations loc) {
    final remaining = (targetDays - currentStreak).clamp(0, targetDays);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem(context, loc.longestStreakLabel, loc.daysCount(longestStreak), Icons.emoji_events),
        _buildStatItem(context, loc.remainingToGoalLabel, loc.daysCount(remaining.toInt()), Icons.flag),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24, color: ColorConstants.secondaryColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}