import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_service.dart';
import 'achievement_service.dart';
import 'user_progress_service.dart';

/// Hook Model Implementation
/// Trigger: Engaging notifications → Action: Opening the app → Reward: Achievement feeling + visual effects
class HookModelService {
  static final HookModelService _instance = HookModelService._internal();
  factory HookModelService() => _instance;
  HookModelService._internal();

  final NotificationService _notificationService = NotificationService();
  final AchievementService _achievementService = AchievementService();
  final UserProgressService _progressService = UserProgressService();
  
  static const String _lastNotificationTriggerKey = 'last_notification_trigger';
  static const String _appOpensFromNotificationKey = 'app_opens_from_notification';

  /// Trigger: Send engaging notification
  Future<void> triggerEngagingNotification({
    required String title,
    required String body,
    DateTime? scheduledTime,
  }) async {
    try {
      await _notificationService.initialize();
      
      if (scheduledTime != null) {
        // Generate a unique ID for the notification
        final notificationId = DateTime.now().millisecondsSinceEpoch % 100000;
        
        // Use scheduleNotification instead of scheduleTaskReminder
        await _notificationService.scheduleNotification(
          id: notificationId,
          title: title,
          body: body,
          scheduledTime: scheduledTime,
        );
      } else {
        // Use showSimpleNotification instead of showTaskReminderNotification
        await _notificationService.showSimpleNotification(
          title: title,
          body: body,
        );
      }

      // Track notification trigger
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastNotificationTriggerKey, DateTime.now().toIso8601String());
      
      log('Engaging notification triggered: $title');
    } catch (e) {
      log('Error triggering notification: $e', error: e);
    }
  }

  /// Action: Handle app opening (reward user for coming back)
  Future<void> handleAppOpening() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastTrigger = prefs.getString(_lastNotificationTriggerKey);
      final opensFromNotification = prefs.getBool(_appOpensFromNotificationKey) ?? false;

      if (lastTrigger != null && opensFromNotification) {
        // User opened app from notification - give reward
        await _rewardAppOpening();
        
        // Reset flag
        await prefs.setBool(_appOpensFromNotificationKey, false);
      }

      // Update last active for streak
      await _progressService.updateStreak();
    } catch (e) {
      log('Error handling app opening: $e', error: e);
    }
  }

  /// Reward: Give achievement feeling + visual effects
  Future<void> _rewardAppOpening() async {
    try {
      // Award bonus points for opening from notification
      await _progressService.updateUserPoints(5);
      
      // Check for surprise achievements
      final random = DateTime.now().millisecond % 100;
      if (random < 5) { // 5% chance
        // Unlock a surprise achievement
        final achievements = await _achievementService.getAllAchievements();
        final unlocked = await _achievementService.getUnlockedAchievements();
        final unlockedIds = unlocked.map((a) => a.id).toList();
        final locked = achievements.where((a) => 
          !unlockedIds.contains(a.id)
        ).toList();
        
        if (locked.isNotEmpty) {
          final randomAchievement = locked[random % locked.length];
          await _achievementService.unlockAchievement(randomAchievement.id);
        }
      }

      log('Reward given for app opening from notification');
    } catch (e) {
      log('Error rewarding app opening: $e', error: e);
    }
  }

  /// Mark that app was opened from notification
  Future<void> markOpenedFromNotification() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_appOpensFromNotificationKey, true);
    } catch (e) {
      log('Error marking notification open: $e', error: e);
    }
  }

  /// Schedule engaging notifications throughout the day
  Future<void> scheduleEngagingNotifications() async {
    try {
      final now = DateTime.now();
      
      // Morning notification (9 AM)
      var morningTime = DateTime(now.year, now.month, now.day, 9, 0);
      if (now.hour >= 9) {
        morningTime = morningTime.add(const Duration(days: 1));
      }
      await triggerEngagingNotification(
        title: '🌅 Good Morning!',
        body: 'Start your day strong with your first task!',
        scheduledTime: morningTime,
      );

      // Afternoon notification (2 PM)
      var afternoonTime = DateTime(now.year, now.month, now.day, 14, 0);
      if (now.hour >= 14) {
        afternoonTime = afternoonTime.add(const Duration(days: 1));
      }
      await triggerEngagingNotification(
        title: '⏰ Afternoon Check-in',
        body: 'Keep the momentum going!',
        scheduledTime: afternoonTime,
      );

      // Evening notification (7 PM)
      var eveningTime = DateTime(now.year, now.month, now.day, 19, 0);
      if (now.hour >= 19) {
        eveningTime = eveningTime.add(const Duration(days: 1));
      }
      await triggerEngagingNotification(
        title: '🌆 Evening Push',
        body: 'Finish strong! Complete your remaining tasks.',
        scheduledTime: eveningTime,
      );
    } catch (e) {
      log('Error scheduling engaging notifications: $e', error: e);
    }
  }
}