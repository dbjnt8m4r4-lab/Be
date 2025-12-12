import 'dart:convert'; // ADD THIS LINE
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> saveDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  Future<void> saveStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  // For complex data structures - THESE NEED dart:convert
  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(value);
    await prefs.setString(key, jsonString);
  }

  Future<Map<String, dynamic>?> getMap(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      return Map<String, dynamic>.from(json.decode(jsonString));
    }
    return null;
  }

  Future<void> saveList(String key, List<dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(value);
    await prefs.setString(key, jsonString);
  }

  Future<List<dynamic>?> getList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      return json.decode(jsonString) as List<dynamic>;
    }
    return null;
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}