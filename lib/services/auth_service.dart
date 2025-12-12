import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user => _auth.authStateChanges();

  Future<User?> signInWithGoogle() async {
    try {
      // Google Sign In is not fully implemented yet
      // This is a placeholder that returns null
      // TODO: Implement proper Google Sign In when package is properly configured
      return null;
    } catch (e) {
      print('Google sign-in error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Simple anonymous auth as fallback
  Future<User?> signInAnonymously() async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print('Anonymous sign-in error: $e');
      return null;
    }
  }
}