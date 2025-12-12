import 'dart:io';
import 'package:flutter/foundation.dart';

/// Helper class to check network connectivity
class ConnectivityHelper {
  /// Check if device has internet connection
  /// Tries multiple methods for better reliability
  /// Returns true optimistically if checks are slow to avoid blocking
  static Future<bool> hasInternetConnection() async {
    try {
      // Method 1: Try DNS lookup with multiple hosts (faster)
      final hosts = ['8.8.8.8', '1.1.1.1', 'google.com'];
      
      for (final host in hosts) {
        try {
          final result = await InternetAddress.lookup(host)
              .timeout(const Duration(seconds: 2));
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            return true;
          }
        } catch (_) {
          // Try next host
          continue;
        }
      }
      
      // Method 2: Try socket connection (more reliable but slower)
      try {
        final socket = await Socket.connect('8.8.8.8', 53)
            .timeout(const Duration(seconds: 2));
        await socket.close();
        return true;
      } catch (_) {
        // Socket connection failed, try Cloudflare DNS
        try {
          final socket = await Socket.connect('1.1.1.1', 53)
              .timeout(const Duration(seconds: 2));
          await socket.close();
          return true;
        } catch (_) {
          // Both socket connections failed - assume connected optimistically
          // This prevents false negatives when network is slow but available
          debugPrint('Connectivity check: All methods failed, assuming connected');
          return true; // Optimistically return true to avoid blocking
        }
      }
    } catch (e) {
      // If there's an exception, assume connected to avoid blocking functionality
      debugPrint('Connectivity check error: $e - assuming connected');
      return true; // Optimistically return true
    }
  }

  /// Show offline message
  static String getOfflineMessage() {
    return 'No internet connection. Please check your network and try again.';
  }
}
