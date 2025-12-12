import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../services/notification_service.dart';

class NotificationUtils {
  static final NotificationService _notificationService = NotificationService();

  static Future<void> initializeNotifications() async {
    await _notificationService.initialize();
  }

  static Future<void> scheduleTaskNotification({
    required String taskTitle,
    required DateTime scheduledTime,
    required String taskId,
  }) async {
    await _notificationService.scheduleTaskReminder(
      taskId: taskId,
      taskTitle: taskTitle,
      reminderTime: scheduledTime,
    );
  }

  static Future<void> showDailySummaryNotification({
    required double points,
    required String grade,
    required bool isSuccessful,
  }) async {
    final message = isSuccessful
        ? 'أحسنت! لقد حصلت على $points نقطة ($grade) اليوم'
        : 'يمكنك التحسن! حصلت على $points نقطة ($grade) اليوم';

    await _notificationService.showDailySummary(
      completedTasks: 0, // Placeholder as original logic didn't pass this
      totalPoints: points.toInt(),
    );
  }

  static Future<void> cancelTaskNotification(String taskId) async {
    await _notificationService.cancelNotification(taskId.hashCode);
  }

  static Future<void> requestPermissions() async {
    // Request notification permissions
    final FlutterLocalNotificationsPlugin notifications =
        FlutterLocalNotificationsPlugin();

    // For iOS
    await notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

      // For Android, request notification permission via permission_handler
      try {
        if (await Permission.notification.isDenied) {
          await Permission.notification.request();
        }
      } catch (_) {
        // permission_handler may not support web/desktop — ignore failures
      }
  }
}