import 'package:http/http.dart' as http;
import 'dart:convert';

class TurnstileService {
  static const String _verifyUrl = 'https://challenges.cloudflare.com/turnstile/v0/siteverify';
  final String _secretKey;

  TurnstileService({required String secretKey}) : _secretKey = secretKey;

  /// Verifies the Turnstile token with Cloudflare's API
  /// Returns true if verification is successful, false otherwise
  Future<bool> verifyToken(String token) async {
    try {
      final response = await http.post(
        Uri.parse(_verifyUrl),
        body: {
          'secret': _secretKey,
          'response': token,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print('Error verifying Turnstile token: $e');
      return false;
    }
  }
}
