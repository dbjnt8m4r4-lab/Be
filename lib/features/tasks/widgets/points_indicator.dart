import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/utils/grade_calculator.dart';

class PointsIndicator extends StatelessWidget {
  final double points;
  final int totalPoints;
  final bool isSuccessful;
  final String dailyLabel;
  final String statusOnTrack;
  final String statusNeedAttention;

  const PointsIndicator({super.key, 
    required this.points,
    required this.totalPoints,
    required this.isSuccessful,
    required this.dailyLabel,
    required this.statusOnTrack,
    required this.statusNeedAttention,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = points / totalPoints;
    final hasCompletedWork = points > 0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Color coding by rate: green (>=70%), orange (40-69%), red (<40%)
    Color getProgressColor() {
      if (percentage >= 0.7) return ColorConstants.priorityLow; // Green
      if (percentage >= 0.4) return ColorConstants.priorityNormal; // Orange
      return ColorConstants.priorityHigh; // Red
    }
    
    // Get grade and grade color
    final grade = hasCompletedWork ? GradeCalculator.calculateGrade(points) : null;
    final gradeColor = grade != null ? GradeCalculator.getGradeColor(grade) : null;
    
    // Theme-aware colors
    final textColor = isDark ? Colors.white : Colors.black;
    final backgroundColor = isDark 
        ? Colors.white.withAlpha((0.06 * 255).round())
        : Colors.black.withAlpha((0.06 * 255).round());
    final progressBgColor = isDark
        ? Colors.white.withAlpha((0.1 * 255).round())
        : Colors.black.withAlpha((0.1 * 255).round());

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withAlpha((0.3 * 255).round())
                : ColorConstants.blueAccentLight.withAlpha((0.3 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            dailyLabel,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: progressBgColor,
            valueColor: AlwaysStoppedAnimation<Color>(getProgressColor()),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${points.toStringAsFixed(1)} / $totalPoints',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              if (hasCompletedWork)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (grade != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: gradeColor!,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          grade,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSuccessful ? ColorConstants.blueAccentDark : ColorConstants.blueAccentLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isSuccessful ? statusOnTrack : statusNeedAttention,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}