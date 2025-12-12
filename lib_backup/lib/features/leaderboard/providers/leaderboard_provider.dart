import 'package:flutter/foundation.dart';
import '../../../core/utils/habit_points_calculator.dart';
import '../../../core/utils/connectivity_helper.dart';

// TEMPORARY FIX: Define LeaderboardEntry in the same file
class LeaderboardEntry {
  final String userId;
  final String userName;
  final int score;
  final int rank;
  final bool isEligible;

  LeaderboardEntry({
    required this.userId,
    required this.userName,
    required this.score,
    required this.rank,
    this.isEligible = true,
  });
}

class LeaderboardProvider extends ChangeNotifier {
  List<LeaderboardEntry>? _leaderboard;
  bool _isLoading = false;
  String? _error;

  List<LeaderboardEntry>? get leaderboard => _leaderboard;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<LeaderboardEntry> getEligibleEntries() {
    if (_leaderboard == null) return [];
    return _leaderboard!.where((entry) => entry.isEligible).toList();
  }

  Future<void> loadLeaderboard() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // NOTE: In production, this should fetch from Firebase Firestore
      // For now, we'll use mock data that demonstrates the combined scoring
      // Formula: (taskPoints + habitPoints) / 2
      
      // Since we're using mock data, we'll load it regardless of connectivity
      // Connectivity check is non-blocking - we'll try to check but proceed anyway
      ConnectivityHelper.hasInternetConnection()
          .timeout(const Duration(seconds: 1), onTimeout: () => false)
          .catchError((_) => false); // Ignore connectivity errors
      
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      _leaderboard = [
        LeaderboardEntry(
          userId: '1',
          userName: 'User 1',
          score: 95, // Example: (120 + 70) / 2 = 95
          rank: 1,
        ),
        LeaderboardEntry(
          userId: '2',
          userName: 'User 2',
          score: 85, // Example: (100 + 70) / 2 = 85
          rank: 2,
        ),
        LeaderboardEntry(
          userId: '3',
          userName: 'User 3',
          score: 75, // Example: (90 + 60) / 2 = 75
          rank: 3,
        ),
      ];
    } catch (e) {
      _error = 'Failed to load leaderboard: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Calculate leaderboard score from task and habit points
  /// Formula: (taskPoints + habitPoints) / 2
  static int calculateLeaderboardScore(double taskPoints, double habitPoints) {
    return HabitPointsCalculator.calculateLeaderboardScore(taskPoints, habitPoints);
  }

  Future<void> refreshLeaderboard() async {
    await loadLeaderboard();
  }

  List<LeaderboardEntry> getTopUsers(int count) {
    if (_leaderboard == null) return [];
    return _leaderboard!.take(count).toList();
  }
}