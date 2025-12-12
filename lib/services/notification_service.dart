import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  final Map<int, Timer> _timers = {};

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(android: android, iOS: ios);

    await _plugin.initialize(settings, onDidReceiveNotificationResponse: (resp) {
      if (kDebugMode) print('Notification tapped payload=${resp.payload}');
    });
  }

  Future<void> initialize() async {
    await init();
  }

  Future<void> show({required int id, required String title, required String body, String? payload}) async {
    const android = AndroidNotificationDetails(
      'to_be_channel',
      'To Be',
      channelDescription: 'General notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails();
    const details = NotificationDetails(android: android, iOS: ios);
    await _plugin.show(id, title, body, details, payload: payload);
  }

  Future<void> showSimpleNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await show(id: DateTime.now().millisecondsSinceEpoch % 100000, title: title, body: body, payload: payload);
  }

  void scheduleTimer({required int id, required String title, required String body, required Duration duration, String? payload}) {
    _timers[id]?.cancel();
    _timers[id] = Timer(duration, () {
      show(id: id, title: title, body: body, payload: payload);
      _timers.remove(id);
    });
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    final now = DateTime.now();
    final duration = scheduledTime.difference(now);
    if (duration.isNegative) {
      // If time has passed, schedule for tomorrow
      final tomorrow = scheduledTime.add(const Duration(days: 1));
      scheduleTimer(
        id: id,
        title: title,
        body: body,
        duration: tomorrow.difference(now),
        payload: payload,
      );
    } else {
      scheduleTimer(
        id: id,
        title: title,
        body: body,
        duration: duration,
        payload: payload,
      );
    }
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay timeOfDay,
    String? payload,
  }) async {
    final now = DateTime.now();
    var scheduledTime = DateTime(
      now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute,
    );

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    await scheduleNotification(
      id: id, title: title, body: body, scheduledTime: scheduledTime, payload: payload,
    );
  }

  Future<void> showMotivationalQuote({required String quote}) async {
    await showSimpleNotification(title: 'Daily Motivation', body: quote);
  }

  Future<void> scheduleDailyMotivationalQuote() async {
    const time = TimeOfDay(hour: 8, minute: 0);
    await scheduleDailyNotification(
      id: 1, title: 'Daily Motivation', body: 'Time to check your goals!', timeOfDay: time,
    );
  }

  Future<void> cancelNotification(int id) async {
    _timers[id]?.cancel();
    _timers.remove(id);
    await _plugin.cancel(id);
    if (kDebugMode) print('Cancelled notification: $id');
  }

  Future<void> cancelAllNotifications() async {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
    await _plugin.cancelAll();
    if (kDebugMode) print('Cancelled all notifications');
  }

  Future<void> scheduleMotivationalNotifications() async {
    await scheduleDailyMotivationalQuote();
  }

  Future<void> scheduleTaskReminder({
    required String taskId,
    required String taskTitle,
    required DateTime reminderTime,
  }) async {
    await scheduleNotification(
      id: taskId.hashCode,
      title: 'Task Reminder',
      body: taskTitle,
      scheduledTime: reminderTime,
      payload: taskId,
    );
  }

  Future<void> showDailySummary({
    required int completedTasks,
    required int totalPoints,
  }) async {
    await showSimpleNotification(
      title: 'Daily Summary',
      body: 'You completed $completedTasks tasks and earned $totalPoints points!',
    );
  }
}