import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../data/models/habit_model.dart';
import '../../../l10n/app_localizations.dart';

class HabitPointsIndicator extends StatelessWidget {
  final List<Habit> habits;

  const HabitPointsIndicator({
    super.key,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final activeHabits = habits.where((habit) => habit.isActive).length;
    final completedToday = _calculateCompletedToday(habits);
    final hasActiveHabits = activeHabits > 0;
    final hasProgress = hasActiveHabits && completedToday > 0;
    final completionRatio = hasActiveHabits ? (completedToday / activeHabits).clamp(0.0, 1.0) : 0.0;
    final totalPoints = _calculateTotalPoints(habits);
    final grade = hasProgress ? _habitGrade(completionRatio) : '--';
    final isPositive = hasProgress && completionRatio >= 0.5;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.dailyHabitsCardTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.habitsCompletedSummary(completedToday, activeHabits),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${totalPoints.toStringAsFixed(1)} ${loc.pointsLabel}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: hasProgress ? _gradeColor(grade).withOpacity(.15) : Colors.grey.withOpacity(.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    grade,
                    style: TextStyle(
                      color: hasProgress ? _gradeColor(grade) : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: completionRatio,
                minHeight: 10,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isPositive ? ColorConstants.priorityLow : ColorConstants.priorityNormal,
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (hasProgress)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: isPositive ? ColorConstants.blueAccentDark : ColorConstants.blueAccentLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isPositive ? loc.onTrack : loc.needAttention,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  loc.createFirstHabit,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  double _calculateTotalPoints(List<Habit> habits) {
    return habits.fold<double>(0.0, (sum, h) => sum + h.assignedPoints);
  }

  int _calculateCompletedToday(List<Habit> habits) {
    final now = DateTime.now();
    return habits
        .where(
          (h) => h.completedDates.any(
            (d) => d.year == now.year && d.month == now.month && d.day == now.day,
          ),
        )
        .length;
  }

  String _habitGrade(double ratio) {
    if (ratio >= 0.95) return 'A+';
    if (ratio >= 0.9) return 'A';
    if (ratio >= 0.8) return 'B';
    if (ratio >= 0.7) return 'C';
    if (ratio >= 0.5) return 'D';
    return 'F';
  }

  Color _gradeColor(String grade) {
    switch (grade) {
      case 'A+':
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.lightGreen;
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.deepOrange;
      default:
        return Colors.redAccent;
    }
  }
}