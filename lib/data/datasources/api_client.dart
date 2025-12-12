import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  static const String _baseUrl = 'https://your-api-domain.com/api';
  String? _authToken;

  void setAuthToken(String token) {
    _authToken = token;
  }

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    
    return headers;
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: _headers,
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: _headers,
        body: jsonEncode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: _headers,
        body: jsonEncode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: _headers,
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = jsonDecode(response.body);

    if (statusCode >= 200 && statusCode < 300) {
      return responseBody;
    } else if (statusCode == 401) {
      throw Exception('Unauthorized');
    } else if (statusCode == 404) {
      throw Exception('Resource not found');
    } else if (statusCode >= 500) {
      throw Exception('Server error');
    } else {
      throw Exception('Error: ${responseBody['message'] ?? 'Unknown error'}');
    }
  }

  // Specific API methods for the app
  Future<List<dynamic>> getQuickTasks() async {
    final response = await get('quick-tasks');
    return response['data'];
  }

  Future<Map<String, dynamic>> submitDailyResults(Map<String, dynamic> data) async {
    return await post('daily-results', data);
  }

  Future<List<dynamic>> getLeaderboard() async {
    final response = await get('leaderboard');
    return response['data'];
  }

  Future<Map<String, dynamic>> getAnalytics() async {
    return await get('analytics');
  }

  Future<Map<String, dynamic>> createSubscription(Map<String, dynamic> data) async {
    return await post('subscriptions', data);
  }

  Future<Map<String, dynamic>> getAIAdvice(Map<String, dynamic> data) async {
    return await post('ai-advice', data);
  }
}