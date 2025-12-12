import '../models/leaderboard_model.dart';

class LeaderboardRepository {
  Future<Leaderboard> getLeaderboard({
    String timeRange = 'weekly',
  }) async {
    // TODO: Replace with actual Firestore implementation
    // Return mock data for demonstration
    return Leaderboard(
      entries: [
        LeaderboardEntry(
          userId: '1',
          userName: 'أحمد',
          rank: 1,
          totalPoints: 950,
          successfulDays: 28,
          successRate: 0.93,
          currentGrade: 'A+',
        ),
        LeaderboardEntry(
          userId: '2',
          userName: 'محمد',
          rank: 2,
          totalPoints: 890,
          successfulDays: 26,
          successRate: 0.86,
          currentGrade: 'A',
        ),
        LeaderboardEntry(
          userId: '3',
          userName: 'فاطمة',
          rank: 3,
          totalPoints: 850,
          successfulDays: 25,
          successRate: 0.83,
          currentGrade: 'A-',
        ),
        LeaderboardEntry(
          userId: '4',
          userName: 'خالد',
          rank: 4,
          totalPoints: 780,
          successfulDays: 23,
          successRate: 0.76,
          currentGrade: 'B+',
        ),
        LeaderboardEntry(
          userId: '5',
          userName: 'سارة',
          rank: 5,
          totalPoints: 720,
          successfulDays: 21,
          successRate: 0.70,
          currentGrade: 'B',
        ),
        // Example of ineligible user (less than 5 successful days)
        LeaderboardEntry(
          userId: '6',
          userName: 'علي',
          rank: 0, // Not ranked
          totalPoints: 150,
          successfulDays: 3, // Less than 5
          successRate: 0.60,
          currentGrade: 'C',
        ),
      ],
      lastUpdated: DateTime.now(),
      timeRange: timeRange,
    );
  }
}
