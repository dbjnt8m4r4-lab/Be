import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/achievement_model.dart';
import 'user_progress_service.dart';

class AchievementService {
  static final AchievementService _instance = AchievementService._internal();
  factory AchievementService() => _instance;
  AchievementService._internal();

  final UserProgressService _progressService = UserProgressService();
  static const String _achievementsKey = 'user_achievements';
  static const String _unlockedAchievementsKey = 'unlocked_achievements';

  // Predefined achievements
  static final List<Achievement> _allAchievements = [
    // Common achievements
    Achievement(
      id: 'first_task',
      title: 'First Step',
      description: 'Complete your first task',
      emoji: '🎯',
      type: AchievementType.taskCompleted,
      rarity: AchievementRarity.common,
      pointsReward: 10,
    ),
    Achievement(
      id: 'task_master_10',
      title: 'Task Master',
      description: 'Complete 10 tasks',
      emoji: '⭐',
      type: AchievementType.taskCompleted,
      rarity: AchievementRarity.common,
      pointsReward: 50,
      metadata: {'target': 10},
    ),
    Achievement(
      id: 'streak_7',
      title: 'Week Warrior',
      description: 'Maintain a 7-day streak',
      emoji: '🔥',
      type: AchievementType.streakMaintained,
      rarity: AchievementRarity.rare,
      pointsReward: 100,
      metadata: {'target': 7},
    ),
    Achievement(
      id: 'points_100',
      title: 'Centurion',
      description: 'Earn 100 points in a day',
      emoji: '💯',
      type: AchievementType.pointsEarned,
      rarity: AchievementRarity.rare,
      pointsReward: 150,
      metadata: {'target': 100},
    ),
    // Hidden achievements
    Achievement(
      id: 'midnight_warrior',
      title: 'Midnight Warrior',
      description: 'Complete a task after midnight',
      emoji: '🌙',
      type: AchievementType.hidden,
      rarity: AchievementRarity.epic,
      isHidden: true,
      pointsReward: 200,
    ),
    Achievement(
      id: 'early_bird',
      title: 'Early Bird',
      description: 'Complete a task before 6 AM',
      emoji: '🐦',
      type: AchievementType.hidden,
      rarity: AchievementRarity.epic,
      isHidden: true,
      pointsReward: 200,
    ),
    // Seasonal achievements
    Achievement(
      id: 'winter_warrior',
      title: 'Winter Warrior',
      description: 'Complete all tasks in winter',
      emoji: '❄️',
      type: AchievementType.seasonal,
      rarity: AchievementRarity.legendary,
      pointsReward: 500,
    ),
  ];

  Future<List<Achievement>> getAllAchievements() async {
    return _allAchievements;
  }

  Future<List<Achievement>> getUnlockedAchievements() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final unlockedIds = prefs.getStringList(_unlockedAchievementsKey) ?? [];
      return _allAchievements.where((a) => unlockedIds.contains(a.id)).toList();
    } catch (e) {
      log('Error getting unlocked achievements: $e', error: e);
      return [];
    }
  }

  Future<String?> getLastUnlockedAchievementId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final unlockedIds = prefs.getStringList(_unlockedAchievementsKey) ?? [];
      return unlockedIds.isNotEmpty ? unlockedIds.last : null;
    } catch (e) {
      log('Error getting last unlocked achievement: $e', error: e);
      return null;
    }
  }

  Future<List<Achievement>> getLockedAchievements() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final unlockedIds = prefs.getStringList(_unlockedAchievementsKey) ?? [];
      return _allAchievements.where((a) => !unlockedIds.contains(a.id)).toList();
    } catch (e) {
      log('Error getting locked achievements: $e', error: e);
      return [];
    }
  }

  Future<bool> unlockAchievement(String achievementId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final unlockedIds = prefs.getStringList(_unlockedAchievementsKey) ?? [];
      
      if (unlockedIds.contains(achievementId)) {
        return false; // Already unlocked
      }

      unlockedIds.add(achievementId);
      await prefs.setStringList(_unlockedAchievementsKey, unlockedIds);

      // Award points
      final achievement = _allAchievements.firstWhere((a) => a.id == achievementId);
      if (achievement.pointsReward > 0) {
        await _progressService.updateUserPoints(achievement.pointsReward);
      }

      log('Achievement unlocked: $achievementId');
      return true;
    } catch (e) {
      log('Error unlocking achievement: $e', error: e);
      return false;
    }
  }

  Future<bool> checkAchievements({
    int? tasksCompleted,
    int? currentStreak,
    double? pointsEarned,
    DateTime? taskCompletedAt,
  }) async {
    final unlockedIds = await _getUnlockedIds();
    bool anyUnlocked = false;

    // Check task completion achievements
    if (tasksCompleted != null) {
      if (tasksCompleted == 1 && !unlockedIds.contains('first_task')) {
        await unlockAchievement('first_task');
        anyUnlocked = true;
      }
      if (tasksCompleted >= 10 && !unlockedIds.contains('task_master_10')) {
        await unlockAchievement('task_master_10');
        anyUnlocked = true;
      }
    }

    // Check streak achievements
    if (currentStreak != null) {
      if (currentStreak >= 7 && !unlockedIds.contains('streak_7')) {
        await unlockAchievement('streak_7');
        anyUnlocked = true;
      }
    }

    // Check points achievements
    if (pointsEarned != null) {
      if (pointsEarned >= 100 && !unlockedIds.contains('points_100')) {
        await unlockAchievement('points_100');
        anyUnlocked = true;
      }
    }

    // Check hidden achievements
    if (taskCompletedAt != null) {
      final hour = taskCompletedAt.hour;
      if (hour >= 0 && hour < 6 && !unlockedIds.contains('early_bird')) {
        await unlockAchievement('early_bird');
        anyUnlocked = true;
      }
      if (hour >= 0 && hour < 1 && !unlockedIds.contains('midnight_warrior')) {
        await unlockAchievement('midnight_warrior');
        anyUnlocked = true;
      }
    }

    return anyUnlocked;
  }

  Future<List<String>> _getUnlockedIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_unlockedAchievementsKey) ?? [];
    } catch (e) {
      return [];
    }
  }
}

