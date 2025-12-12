import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Updates or creates a user's score in the leaderboard
  Future<void> updateUserScore(String userId, int score) async {
    await _firestore.collection('leaderboard').doc(userId).set({
      'score': score,
      'lastUpdated': FieldValue.serverTimestamp(),
      'userId': userId,
    }, SetOptions(merge: true));
  }

  /// Returns a stream of leaderboard data, ordered by score in descending order
  Stream<QuerySnapshot> getLeaderboard() {
    return _firestore
        .collection('leaderboard')
        .orderBy('score', descending: true)
        .limit(100)
        .snapshots();
  }

  /// Gets the current rank of a user in the leaderboard
  Future<int> getUserRank(String userId) async {
    final snapshot = await _firestore
        .collection('leaderboard')
        .orderBy('score', descending: true)
        .get();

    final docs = snapshot.docs;
    final userIndex = docs.indexWhere((doc) => doc.id == userId);
    return userIndex >= 0 ? userIndex + 1 : -1;
  }

  /// Gets the top N users from the leaderboard
  Future<List<Map<String, dynamic>>> getTopUsers(int limit) async {
    final snapshot = await _firestore
        .collection('leaderboard')
        .orderBy('score', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
