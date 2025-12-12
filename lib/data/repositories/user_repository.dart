import '../models/user_model.dart';
import '../datasources/local_database.dart';
import '../datasources/api_client.dart';

class UserRepository {
  final LocalDatabase _localDatabase = LocalDatabase();
  final ApiClient _apiClient = ApiClient();

  Future<User?> getCurrentUser() async {
    try {
      final userData = await _localDatabase.getMap('current_user');
      return userData != null ? User.fromJson(userData) : null;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  Future<void> saveUser(User user) async {
    try {
      await _localDatabase.saveMap('current_user', user.toJson());
      
      // Also sync with server if available
      try {
        await _apiClient.post('users', user.toJson());
      } catch (e) {
        print('Failed to sync user with server: $e');
      }
    } catch (e) {
      print('Error saving user: $e');
      rethrow;
    }
  }

  Future<void> updateUserStats(double points, bool isSuccessful) async {
    try {
      final user = await getCurrentUser();
      if (user != null) {
        final updatedUser = User(
          id: user.id,
          email: user.email,
          name: user.name,
          photoUrl: user.photoUrl, // CHANGED: avatarUrl → photoUrl
          createdAt: user.createdAt, // CHANGED: joinDate → createdAt
          updatedAt: DateTime.now(),
          totalCompletedDays: user.totalCompletedDays ?? 0,
          totalTasksAddedDays: user.totalTasksAddedDays ?? 0,
          leaderboardEligible: user.leaderboardEligible ?? false,
          averageScore: user.averageScore ?? 0.0,
          fcmToken: user.fcmToken,
          totalPoints: ((user.totalPoints ?? 0) + points).toInt(), // FIXED: null safety
          successfulDays: (user.successfulDays ?? 0) + (isSuccessful ? 1 : 0), // FIXED: null safety
          totalDays: (user.totalDays ?? 0) + 1, // FIXED: null safety
          currentGrade: _calculateOverallGrade((user.totalPoints ?? 0) + points, (user.totalDays ?? 0) + 1), // FIXED: null safety
          preferences: user.preferences,
        );
        await saveUser(updatedUser);
      }
    } catch (e) {
      print('Error updating user stats: $e');
      rethrow;
    }
  }

  String _calculateOverallGrade(double totalPoints, int totalDays) {
    if (totalDays == 0) return 'F'; // Prevent division by zero
    final averagePoints = totalPoints / totalDays;
    if (averagePoints >= 90) return 'A+';
    if (averagePoints >= 80) return 'A';
    if (averagePoints >= 70) return 'B+';
    if (averagePoints >= 60) return 'B';
    if (averagePoints >= 50) return 'C+';
    if (averagePoints >= 40) return 'C';
    if (averagePoints >= 30) return 'D';
    return 'F';
  }

  Future<void> updateUserPreferences(Map<String, dynamic> preferences) async {
    try {
      final user = await getCurrentUser();
      if (user != null) {
        final updatedUser = User(
          id: user.id,
          email: user.email,
          name: user.name,
          photoUrl: user.photoUrl, // CHANGED: avatarUrl → photoUrl
          createdAt: user.createdAt, // CHANGED: joinDate → createdAt
          updatedAt: DateTime.now(),
          totalCompletedDays: user.totalCompletedDays ?? 0,
          totalTasksAddedDays: user.totalTasksAddedDays ?? 0,
          leaderboardEligible: user.leaderboardEligible ?? false,
          averageScore: user.averageScore ?? 0.0,
          fcmToken: user.fcmToken,
          totalPoints: user.totalPoints ?? 0,
          successfulDays: user.successfulDays ?? 0,
          totalDays: user.totalDays ?? 0,
          currentGrade: user.currentGrade,
          preferences: preferences,
        );
        await saveUser(updatedUser);
      }
    } catch (e) {
      print('Error updating user preferences: $e');
      rethrow;
    }
  }

  // Add this method to clear user data on logout
  Future<void> clearUser() async {
    try {
      await _localDatabase.remove('current_user');
    } catch (e) {
      print('Error clearing user: $e');
    }
  }
}