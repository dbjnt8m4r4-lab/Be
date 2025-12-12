import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../data/models/leaderboard_model.dart';
import '../../../core/utils/grade_calculator.dart';

class RankCard extends StatelessWidget {
  final LeaderboardEntry entry;

  const RankCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getRankColor(entry.rank),
          child: Text(
            entry.rank.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          entry.userName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${entry.totalPoints} نقطة'),
            Text('${entry.successfulDays} يوم ناجح'),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: GradeCalculator.getGradeColor(entry.currentGrade),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            entry.currentGrade,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return ColorConstants.accentDark;
      case 2:
        return ColorConstants.accentMid;
      case 3:
        return ColorConstants.accentLight;
      default:
        return ColorConstants.secondaryColor;
    }
  }
}