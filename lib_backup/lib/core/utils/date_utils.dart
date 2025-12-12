import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtils {
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  
  static String formatTime(TimeOfDay time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
  
  static bool isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }
  
  static DateTime getToday() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}