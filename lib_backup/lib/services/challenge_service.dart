import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/challenge_model.dart';
import 'user_progress_service.dart';

class ChallengeService {
  static final ChallengeService _instance = ChallengeService._internal();
  factory ChallengeService() => _instance;
  ChallengeService._internal();

  final UserProgressService _progressService = UserProgressService();
  static const String _challengesKey = 'user_challenges';
  static const String _activeChallengesKey = 'active_challenges';

  Future<List<Challenge>> getDailyChallenges() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    return [
      Challenge(
        id: 'daily_tasks_5',
        title: 'Daily Task Master',
        description: 'Complete 5 tasks today',
        type: ChallengeType.daily,
        startDate: today,
        endDate: tomorrow,
        targetValue: 5,
        pointsReward: 50,
        emoji: '📋',
      ),
      Challenge(
        id: 'daily_points_80',
        title: 'Points Champion',
        description: 'Earn 80 points today',
        type: ChallengeType.daily,
        startDate: today,
        endDate: tomorrow,
        targetValue: 80,
        pointsReward: 100,
        emoji: '💯',
      ),
    ];
  }

  Future<List<Challenge>> getWeeklyChallenges() async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 7));

    return [
      Challenge(
        id: 'weekly_tasks_30',
        title: 'Weekly Warrior',
        description: 'Complete 30 tasks this week',
        type: ChallengeType.weekly,
        startDate: weekStart,
        endDate: weekEnd,
        targetValue: 30,
        pointsReward: 300,
        emoji: '🏆',
      ),
      Challenge(
        id: 'weekly_streak_7',
        title: 'Perfect Week',
        description: 'Maintain a 7-day streak',
        type: ChallengeType.weekly,
        startDate: weekStart,
        endDate: weekEnd,
        targetValue: 7,
        pointsReward: 500,
        emoji: '🔥',
      ),
    ];
  }

  Future<List<Challenge>> getMorningChallenges() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final morningEnd = today.add(const Duration(hours: 12));

    return [
      Challenge(
        id: 'morning_tasks_3',
        title: 'Morning Boost',
        description: 'Complete 3 tasks before noon',
        type: ChallengeType.morning,
        startDate: today,
        endDate: morningEnd,
        targetValue: 3,
        pointsReward: 75,
        emoji: '🌅',
      ),
    ];
  }

  Future<List<Challenge>> getEveningChallenges() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eveningStart = today.add(const Duration(hours: 18));
    final tomorrow = today.add(const Duration(days: 1));

    return [
      Challenge(
        id: 'evening_tasks_2',
        title: 'Evening Finish',
        description: 'Complete 2 tasks in the evening',
        type: ChallengeType.evening,
        startDate: eveningStart,
        endDate: tomorrow,
        targetValue: 2,
        pointsReward: 60,
        emoji: '🌆',
      ),
    ];
  }

  Future<List<Challenge>> getAllActiveChallenges() async {
    final daily = await getDailyChallenges();
    final weekly = await getWeeklyChallenges();
    final morning = await getMorningChallenges();
    final evening = await getEveningChallenges();

    return [
      ...daily,
      ...weekly,
      ...morning,
      ...evening,
    ];
  }

  Future<void> updateChallengeProgress(String challengeId, int increment) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final challengesJson = prefs.getString(_activeChallengesKey);
      
      if (challengesJson == null) return;

      // This would typically update challenge progress
      // For now, we'll track completion
      log('Challenge progress updated: $challengeId +$increment');
    } catch (e) {
      log('Error updating challenge progress: $e', error: e);
    }
  }

  Future<void> completeChallenge(String challengeId) async {
    try {
      final challenges = await getAllActiveChallenges();
      final challenge = challenges.firstWhere((c) => c.id == challengeId);
      
      if (challenge.pointsReward > 0) {
        await _progressService.updateUserPoints(challenge.pointsReward);
      }

      log('Challenge completed: $challengeId');
    } catch (e) {
      log('Error completing challenge: $e', error: e);
    }
  }

  String getSeasonalChallenge() {
    final now = DateTime.now();
    final month = now.month;
    
    if (month >= 12 || month <= 2) {
      return 'winter';
    } else if (month >= 3 && month <= 5) {
      return 'spring';
    } else if (month >= 6 && month <= 8) {
      return 'summer';
    } else {
      return 'autumn';
    }
  }
}





