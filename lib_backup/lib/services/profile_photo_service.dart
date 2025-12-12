import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class ProfilePhotoService {
  static final ProfilePhotoService _instance = ProfilePhotoService._internal();

  factory ProfilePhotoService() {
    return _instance;
  }

  ProfilePhotoService._internal();

  Future<String?> uploadProfilePhoto(File imageFile) async {
    try {
      final user = fb.FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      // Create a unique filename
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      // Reference to storage location with userId in path
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_photos')
          .child(user.uid)
          .child(fileName);

      // Upload the file
      final uploadTask = storageRef.putFile(
        imageFile,
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'userId': user.uid,
            'uploadedAt': DateTime.now().toIso8601String(),
          },
        ),
      );

      // Monitor upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        // Progress monitoring available here
        // You could use this for progress indicators
        // final progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      });

      // Wait for upload to complete
      final result = await uploadTask;

      // Get the download URL
      final downloadUrl = await result.ref.getDownloadURL();

      // Update Firebase Auth user profile
      await user.updatePhotoURL(downloadUrl);
      
      // Reload user to ensure changes are reflected
      await user.reload();

      return downloadUrl;
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      switch (e.code) {
        case 'permission-denied':
          throw Exception(
            'Permission denied. Make sure your Firebase Storage rules allow authenticated users to write. '
            'Check: https://console.firebase.google.com/project/_/storage/rules'
          );
        case 'storage/bucket-not-found':
          throw Exception('Firebase Storage bucket not found. Check your Firebase configuration.');
        case 'storage/object-not-found':
          throw Exception('File not found after upload.');
        case 'storage/retry-limit-exceeded':
          throw Exception('Upload failed after multiple retries. Please check your connection and try again.');
        case 'storage/invalid-argument':
          throw Exception('Invalid file or upload parameters.');
        default:
          throw Exception('Firebase Storage error: ${e.message ?? e.code}');
      }
    } catch (e) {
      throw Exception('Failed to upload profile photo: $e');
    }
  }
}
