import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class UserProgressService {
  static final UserProgressService _instance = UserProgressService._internal();
  factory UserProgressService() => _instance;
  UserProgressService._internal();

  static const String _pointsKey = 'user_points';
  static const String _streakKey = 'user_streak';
  static const String _lastActiveKey = 'last_active';

  Future<void> updateUserPoints(int points) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int currentPoints = prefs.getInt(_pointsKey) ?? 0;
      await prefs.setInt(_pointsKey, currentPoints + points);
      log('User points updated: ${currentPoints + points}');
    } catch (e) {
      log('Error updating user points: $e', error: e);
    }
  }

  Future<int> getUserPoints() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_pointsKey) ?? 0;
    } catch (e) {
      log('Error getting user points: $e', error: e);
      return 0;
    }
  }

  Future<void> updateStreak() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int currentStreak = prefs.getInt(_streakKey) ?? 0;
      final lastActiveString = prefs.getString(_lastActiveKey);
      
      if (lastActiveString != null && lastActiveString.isNotEmpty) {
        DateTime lastActive = DateTime.parse(lastActiveString);
        final now = DateTime.now();
        final daysDifference = now.difference(lastActive).inDays;
        
        // Check if user maintained streak (exactly 1 day difference)
        if (daysDifference == 1) {
          await prefs.setInt(_streakKey, currentStreak + 1);
          log('Streak updated: ${currentStreak + 1}');
        } else if (daysDifference > 1) {
          // Streak broken, reset to 1
          await prefs.setInt(_streakKey, 1);
          log('Streak reset to 1');
        }
      } else {
        // First time, start streak at 1
        await prefs.setInt(_streakKey, 1);
        log('Streak started: 1');
      }
      
      // Update last active date
      await prefs.setString(_lastActiveKey, DateTime.now().toIso8601String());
    } catch (e) {
      log('Error updating streak: $e', error: e);
    }
  }

  Future<int> getUserStreak() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_streakKey) ?? 0;
    } catch (e) {
      log('Error getting user streak: $e', error: e);
      return 0;
    }
  }

  Future<bool> shouldShowStreakReward() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastActiveString = prefs.getString(_lastActiveKey);
      
      if (lastActiveString == null || lastActiveString.isEmpty) {
        return false;
      }
      
      DateTime lastActive = DateTime.parse(lastActiveString);
      final now = DateTime.now();
      final daysDifference = now.difference(lastActive).inDays;
      
      // Show reward if streak was just maintained (1 day difference)
      return daysDifference == 1;
    } catch (e) {
      log('Error checking streak reward: $e', error: e);
      return false;
    }
  }

  Future<bool> shouldTriggerConfetti(int points) async {
    // Trigger confetti for major achievements (100+ points)
    return points >= 100;
  }
}





