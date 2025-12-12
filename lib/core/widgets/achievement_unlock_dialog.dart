import 'package:flutter/material.dart';
import '../../data/models/achievement_model.dart';
import '../../l10n/app_localizations.dart';

class AchievementUnlockDialog extends StatelessWidget {
  final Achievement achievement;

  const AchievementUnlockDialog({
    super.key,
    required this.achievement,
  });

  Color _getRarityColor() {
    switch (achievement.rarity) {
      case AchievementRarity.common:
        return Colors.blue;
      case AchievementRarity.rare:
        return Colors.purple;
      case AchievementRarity.epic:
        return Colors.orange;
      case AchievementRarity.legendary:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final rarityColor = _getRarityColor();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Achievement Badge
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: rarityColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: rarityColor.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  achievement.emoji,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Title
            Text(
              loc?.awesome ?? 'Achievement Unlocked!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: rarityColor,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 12),
            
            // Achievement Name
            Text(
              achievement.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            // Achievement Description
            Text(
              achievement.description,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.black54,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),

            if (achievement.pointsReward > 0) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: rarityColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: rarityColor, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '+${achievement.pointsReward} points',
                      style: TextStyle(
                        fontSize: 14,
                        color: rarityColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 20),
            
            // OK Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: rarityColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  loc?.done ?? 'Continue',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}