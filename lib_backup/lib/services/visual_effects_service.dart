import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VisualEffectsService {
  static final VisualEffectsService _instance = VisualEffectsService._internal();
  factory VisualEffectsService() => _instance;
  VisualEffectsService._internal();

  // Haptic feedback for achievements
  Future<void> triggerHapticFeedback(HapticFeedbackType type) async {
    switch (type) {
      case HapticFeedbackType.light:
        await HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.medium:
        await HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.heavy:
        await HapticFeedback.heavyImpact();
        break;
      case HapticFeedbackType.selection:
        await HapticFeedback.selectionClick();
        break;
      case HapticFeedbackType.vibrate:
        await HapticFeedback.vibrate();
        break;
    }
  }

  // Get color based on performance
  Color getPerformanceColor(double performance) {
    if (performance >= 0.8) {
      return Colors.green;
    } else if (performance >= 0.6) {
      return Colors.orange;
    } else if (performance >= 0.4) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  // Get gradient colors based on performance
  List<Color> getPerformanceGradient(double performance) {
    if (performance >= 0.8) {
      return [Colors.green.shade400, Colors.green.shade700];
    } else if (performance >= 0.6) {
      return [Colors.orange.shade400, Colors.orange.shade700];
    } else if (performance >= 0.4) {
      return [Colors.yellow.shade400, Colors.yellow.shade700];
    } else {
      return [Colors.red.shade400, Colors.red.shade700];
    }
  }

  // Animation curves for different effects
  Curve getCompletionCurve() => Curves.elasticOut;
  Curve getProgressCurve() => Curves.easeInOut;
  Curve getRewardCurve() => Curves.bounceOut;
}

enum HapticFeedbackType {
  light,
  medium,
  heavy,
  selection,
  vibrate,
}





