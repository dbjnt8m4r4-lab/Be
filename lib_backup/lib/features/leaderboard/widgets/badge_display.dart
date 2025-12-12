import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';

class BadgeDisplay extends StatelessWidget {
  final String badgeName;
  final String badgeDescription;
  final bool unlocked;
  final IconData icon;

  const BadgeDisplay({super.key, 
    required this.badgeName,
    required this.badgeDescription,
    required this.unlocked,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: unlocked ? ColorConstants.accentDark : ColorConstants.accentMid,
          size: 32,
        ),
        title: Text(
          badgeName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: unlocked ? ColorConstants.primaryColor : ColorConstants.accentMid,
          ),
        ),
        subtitle: Text(
          badgeDescription,
          style: TextStyle(
            color: unlocked ? ColorConstants.accentMid : ColorConstants.accentLight,
          ),
        ),
        trailing: unlocked
            ? const Icon(Icons.verified, color: ColorConstants.accentDark)
            : const Icon(Icons.lock, color: ColorConstants.accentMid),
      ),
    );
  }
}