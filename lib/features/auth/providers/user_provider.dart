import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/auth_service.dart';
import '../../../services/leaderboard_service.dart';

class UserProvider with ChangeNotifier {
  final AuthService _authService;
  final LeaderboardService _leaderboardService;
  
  User? _user;
  int _score = 0;

  User? get user => _user;
  int get score => _score;

  UserProvider(this._authService, this._leaderboardService) {
    _authService.user.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
  }

  Future<void> updateScore(int newScore) async {
    if (_user != null) {
      _score = newScore;
      await _leaderboardService.updateUserScore(_user!.uid, newScore);
      notifyListeners();
    }
  }
}
