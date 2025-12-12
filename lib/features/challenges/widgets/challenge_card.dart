import 'package:flutter/material.dart';
import '../../../data/models/challenge_model.dart';
import '../../../services/visual_effects_service.dart';

class ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final VoidCallback? onTap;

  const ChallengeCard({
    super.key,
    required this.challenge,
    this.onTap,
  });

  Color _getStatusColor() {
    switch (challenge.status) {
      case ChallengeStatus.completed:
        return Colors.green;
      case ChallengeStatus.inProgress:
        return Colors.blue;
      case ChallengeStatus.expired:
        return Colors.grey;
      case ChallengeStatus.notStarted:
        return Colors.orange;
    }
  }

  String _getStatusText() {
    switch (challenge.status) {
      case ChallengeStatus.completed:
        return 'Completed';
      case ChallengeStatus.inProgress:
        return 'In Progress';
      case ChallengeStatus.expired:
        return 'Expired';
      case ChallengeStatus.notStarted:
        return 'Not Started';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusColor = _getStatusColor();
    final performanceColor = VisualEffectsService().getPerformanceColor(challenge.progress);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: statusColor.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (challenge.emoji != null)
                    Text(
                      challenge.emoji!,
                      style: const TextStyle(fontSize: 32),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          challenge.description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getStatusText(),
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Progress bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${challenge.currentValue} / ${challenge.targetValue}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: challenge.progress,
                      minHeight: 8,
                      backgroundColor: isDark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(performanceColor),
                    ),
                  ),
                ],
              ),
              if (challenge.pointsReward > 0) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '${challenge.pointsReward} points reward',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}





