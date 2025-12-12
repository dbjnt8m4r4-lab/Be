import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../core/utils/connectivity_helper.dart';

class AuthProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  User? _currentUser;

  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;

  AuthProvider() {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _currentUser = await _userRepository.getCurrentUser();
    } catch (e) {
      _error = 'Failed to load user';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password, {String? turnstileToken}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Check internet connection first
      final hasConnection = await ConnectivityHelper.hasInternetConnection();
      if (!hasConnection) {
        _error = ConnectivityHelper.getOfflineMessage();
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Turnstile is enforced in the UI layer; this method performs Firebase Auth login.
      final cred = await fb.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final fbUser = cred.user;
      if (fbUser == null) {
        _error = 'Login failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final user = User(
        id: fbUser.uid,
        name: fbUser.displayName ?? 'User',
        email: fbUser.email ?? email,
        photoUrl: fbUser.photoURL, // Use photoUrl instead of avatarUrl
        createdAt: DateTime.now(), // Use createdAt instead of joinDate
        // Add required default values for other properties
        totalCompletedDays: 0,
        totalTasksAddedDays: 0,
        leaderboardEligible: false,
        averageScore: 0.0,
        totalPoints: 0,
      );

      await _setAuthenticatedUser(user);

      _isLoading = false;
      notifyListeners();
      return true;
    } on fb.FirebaseAuthException catch (e) {
      _error = e.message ?? 'Login failed';
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Login failed';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup(String name, String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Check internet connection first
      final hasConnection = await ConnectivityHelper.hasInternetConnection();
      if (!hasConnection) {
        _error = ConnectivityHelper.getOfflineMessage();
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final cred = await fb.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final fbUser = cred.user;
      if (fbUser == null) {
        _error = 'Signup failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final user = User(
        id: fbUser.uid,
        name: name,
        email: fbUser.email ?? email,
        photoUrl: fbUser.photoURL, // Use photoUrl instead of avatarUrl
        createdAt: DateTime.now(), // Use createdAt instead of joinDate
        // Add required default values for other properties
        totalCompletedDays: 0,
        totalTasksAddedDays: 0,
        leaderboardEligible: false,
        averageScore: 0.0,
      );

      await _setAuthenticatedUser(user);

      _isLoading = false;
      notifyListeners();
      return true;
    } on fb.FirebaseAuthException catch (e) {
      _error = e.message ?? 'Signup failed';
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Signup failed';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
     await _userRepository.clearUser();
    _currentUser = null;
    notifyListeners();
  }

  Future<bool> loginWithGoogle() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Check internet connection first
      final hasConnection = await ConnectivityHelper.hasInternetConnection();
      if (!hasConnection) {
        _error = ConnectivityHelper.getOfflineMessage();
        _isLoading = false;
        notifyListeners();
        return false;
      }

      await Future.delayed(const Duration(milliseconds: 900));
      final user = User(
        id: 'google_${DateTime.now().millisecondsSinceEpoch}',
        name: 'Google User',
        email: 'google_user@example.com',
        photoUrl: null, // Use photoUrl instead of avatarUrl
        createdAt: DateTime.now(), // Use createdAt instead of joinDate
        // Add required default values for other properties
        totalCompletedDays: 0,
        totalTasksAddedDays: 0,
        leaderboardEligible: false,
        averageScore: 0.0,
      );
      await _setAuthenticatedUser(user);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Google sign-in failed';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> loginWithApple() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Check internet connection first
      final hasConnection = await ConnectivityHelper.hasInternetConnection();
      if (!hasConnection) {
        _error = ConnectivityHelper.getOfflineMessage();
        _isLoading = false;
        notifyListeners();
        return false;
      }

      await Future.delayed(const Duration(milliseconds: 900));
      final user = User(
        id: 'apple_${DateTime.now().millisecondsSinceEpoch}',
        name: 'Apple User',
        email: 'apple_user@example.com',
        photoUrl: null, // Use photoUrl instead of avatarUrl
        createdAt: DateTime.now(), // Use createdAt instead of joinDate
        // Add required default values for other properties
        totalCompletedDays: 0,
        totalTasksAddedDays: 0,
        leaderboardEligible: false,
        averageScore: 0.0,
      );
      await _setAuthenticatedUser(user);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Apple sign-in failed';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> _setAuthenticatedUser(User user) async {
    await _userRepository.saveUser(user);
    _currentUser = user;
  }

  Future<void> assignRandomAvatar() async {
    if (_currentUser == null) return;
    final avatars = [
      'https://api.dicebear.com/7.x/fun-emoji/png?seed=alpha',
      'https://api.dicebear.com/7.x/fun-emoji/png?seed=bravo',
      'https://api.dicebear.com/7.x/fun-emoji/png?seed=charlie',
      'https://api.dicebear.com/7.x/fun-emoji/png?seed=delta',
    ];
    final index = DateTime.now().millisecondsSinceEpoch % avatars.length;
    final updatedUser = User(
      id: _currentUser!.id,
      name: _currentUser!.name,
      email: _currentUser!.email,
      photoUrl: avatars[index], // Use photoUrl instead of avatarUrl
      createdAt: _currentUser!.createdAt,
      updatedAt: DateTime.now(),
      totalCompletedDays: _currentUser!.totalCompletedDays ?? 0,
      totalTasksAddedDays: _currentUser!.totalTasksAddedDays ?? 0,
      leaderboardEligible: _currentUser!.leaderboardEligible ?? false,
      averageScore: _currentUser!.averageScore ?? 0.0,
      fcmToken: _currentUser!.fcmToken,
    );
    await _setAuthenticatedUser(updatedUser);
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await fb.FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Failed to send password reset email');
    } catch (e) {
      throw Exception('Failed to send password reset email: $e');
    }
  }
}