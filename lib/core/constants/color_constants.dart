import 'package:flutter/material.dart';
import 'app_constants.dart';

class ColorConstants {
  // Glassy black/white/grey/blue palette

  // Base Colors
  static const Color blackColor = Color(0xFF000000);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color darkGrey = Color(0xFF1C1C1C);
  static const Color midGrey = Color(0xFF555555);
  static const Color lightGrey = Color(0xFFAAAAAA);

  // Glassy translucent colors
  static const Color glassyBlack = Color(0xCC000000); // 80% opacity black
  static const Color glassyWhite = Color(0xCCFFFFFF); // 80% opacity white

  // Low opacity white colors for theme text
  static const Color whiteColor70 = Color(0xB3FFFFFF); // 70% opacity white
  static const Color whiteColor54 = Color(0x8AFFFFFF); // 54% opacity white

  // Accent Blue Colors
  static const Color blueAccent = Color(0xFF4A90E2);
  static const Color blueAccentLight = Color(0xFF7AB8F5);
  static const Color blueAccentDark = Color(0xFF2A62B7);

  // Priority colors (green, yellow, red for importance)
  static const Color priorityHigh = Color(0xFFE53935); // Red
  static const Color priorityNormal = Color(0xFFFFC107); // Yellow
  static const Color priorityLow = Color(0xFF4CAF50); // Green

  // Semantic colors
  static const Color successColor = priorityLow; // Green
  static const Color warningColor = priorityNormal; // Yellow
  static const Color errorColor = priorityHigh; // Red

  // Backgrounds and surfaces
  static const Color backgroundColor = blackColor;
  static const Color darkBackground = Color(0xFF000814);
  static const Color surfaceColor = glassyWhite;

  // Add these missing colors that are referenced in other files
  static const Color accentLight = blueAccentLight;
  static const Color accentDark = blueAccentDark;
  static const Color accentMid = blueAccent;
  static const Color primaryColor = blueAccent;
  static const Color secondaryColor = blueAccentLight;

  static Color getPriorityColor(String priority) {
    switch (priority) {
      case Priority.high:
        return priorityHigh;
      case Priority.normal:
        return priorityNormal;
      case Priority.low:
        return priorityLow;
      default:
        return Colors.grey;
    }
  }
}