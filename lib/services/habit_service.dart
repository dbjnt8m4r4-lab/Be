import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/habit_model.dart';

class HabitService {
  static const String _habitsKey = 'bad_habits';

  static Future<BadHabit> recordHabitOccurrence(BadHabit habit, int count) async {
    final updatedRecords = List<HabitRecord>.from(habit.records);
    updatedRecords.add(HabitRecord(
      date: DateTime.now(),
      occurrences: count,
      isImproved: count < habit.dailyOccurrences,
    ));
    
    final updatedHabit = habit.copyWith(records: updatedRecords);
    final habitWithRate = _updateHabitSuccessRate(updatedHabit);
    await _saveHabitData(habitWithRate);
    return habitWithRate;
  }

  static BadHabit _updateHabitSuccessRate(BadHabit habit) {
    if (habit.records.isEmpty) {
      return habit.copyWith(successRate: 0.0);
    }
    
    int improvedDays = habit.records.where((r) => r.isImproved).length;
    double newSuccessRate = (improvedDays / habit.records.length) * 100;
    return habit.copyWith(successRate: newSuccessRate);
  }

  static Future<void> _saveHabitData(BadHabit habit) async {
    final prefs = await SharedPreferences.getInstance();
    // TODO: Implement actual saving logic using a proper database
    // This is a placeholder for demonstration
    await prefs.setString(_habitsKey, '${habit.id}:${habit.records.length}');
  }

  static String getHabitAdvice(BadHabit habit) {
    double rate = habit.successRate;
    if (rate < 30) {
      return "حاول تقليل ${habit.name} بشكل تدريجي. ابدأ بخفض مرة واحدة يومياً";
    } else if (rate < 60) {
      return "أداؤك جيد ولكن يمكنك التحسن. حاول تحديد أوقات محددة ل${habit.name}";
    } else {
      return "ممتاز! استمر في التقدم تجاه التخلص من ${habit.name}";
    }
  }

  static Future<List<BadHabit>> getCommonBadHabits() async {
    return [
      BadHabit(
        id: '1',
        name: 'التأخر في النوم',
        description: 'النوم بعد منتصف الليل',
        dailyOccurrences: 1,
        targetReduction: 0,
        startDate: DateTime.now(),
      ),
      BadHabit(
        id: '2',
        name: 'إضاعة الوقت على السوشيال ميديا',
        description: 'قضاء وقت طويل على التطبيقات الاجتماعية',
        dailyOccurrences: 3,
        targetReduction: 1,
        startDate: DateTime.now(),
      ),
      BadHabit(
        id: '3',
        name: 'تناول الوجبات السريعة',
        description: 'تناول الأطعمة غير الصحية بشكل متكرر',
        dailyOccurrences: 2,
        targetReduction: 1,
        startDate: DateTime.now(),
      ),
      BadHabit(
        id: '4',
        name: 'التسويف',
        description: 'تأجيل المهام المهمة',
        dailyOccurrences: 3,
        targetReduction: 1,
        startDate: DateTime.now(),
      ),
    ];
  }

  static Future<void> saveHabits(List<BadHabit> habits) async {
    final prefs = await SharedPreferences.getInstance();
    // TODO: Implement proper serialization and saving logic
    await prefs.setString(_habitsKey, 'saved_habits');
  }

  static Future<List<BadHabit>> loadHabits() async {
    // TODO: Implement proper loading logic from persistent storage
    return getCommonBadHabits();
  }
}
