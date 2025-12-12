import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../data/models/leaderboard_model.dart';

class TopUsers extends StatelessWidget {
  final List<LeaderboardEntry> entries;

  const TopUsers({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorConstants.accentLight.withAlpha((0.04 * 255).round()),
            ColorConstants.accentMid.withAlpha((0.04 * 255).round()),
          ],
        ),
      ),
      child: Column(
        children: [
          const Text(
            'أفضل المستخدمين',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (entries.length > 1) _buildTopUser(entries[1], 2),
              if (entries.isNotEmpty) _buildTopUser(entries[0], 1),
              if (entries.length > 2) _buildTopUser(entries[2], 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopUser(LeaderboardEntry entry, int rank) {
    double size = 80;
    Color color = ColorConstants.accentLight;

    if (rank == 1) {
      size = 100;
      color = ColorConstants.accentDark;
    } else if (rank == 2) {
      size = 90;
      color = ColorConstants.accentMid;
    } else if (rank == 3) {
      size = 80;
      color = ColorConstants.accentLight;
    }

    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: size / 2,
              backgroundColor: color,
              child: Icon(
                Icons.person,
                size: size * 0.6,
                color: ColorConstants.surfaceColor,
              ),
            ),
            if (rank == 1)
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.star,
                  color: ColorConstants.accentMid,
                  size: 24,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          entry.userName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('${entry.totalPoints} نقطة'),
        Text('المرتبة $rank'),
      ],
    );
  }
}