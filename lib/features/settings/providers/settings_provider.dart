import 'package:flutter/foundation.dart';
import '../../../data/datasources/local_database.dart';

class SettingsProvider extends ChangeNotifier {
  final LocalDatabase _db = LocalDatabase();

  // Keys: theme -> 'light'|'dark', language -> locale code, analytics -> bool, notifications -> bool
  String _theme = 'light';
  String get theme => _theme;

  String _language = 'en';
  String get language => _language;

  bool _analyticsEnabled = true;
  bool get analyticsEnabled => _analyticsEnabled;

  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  String _disciplineProgram = 'standard'; // 'standard' or 'extra'
  String get disciplineProgram => _disciplineProgram;
  bool get isExtraDiscipline => _disciplineProgram == 'extra';

  String _username = '';
  String get username => _username;

  String _email = '';
  String get email => _email;

  int? _age;
  int? get age => _age;

  SettingsProvider() {
    _load();
  }

  Future<void> _load() async {
    try {
      final map = await _db.getMap('settings');
      if (map != null) {
        _theme = map['theme']?.toString() ?? _theme;
        _language = map['language']?.toString() ?? _language;
        _analyticsEnabled = map['analytics'] == null ? _analyticsEnabled : (map['analytics'] == true);
        _notificationsEnabled = map['notifications'] == null ? _notificationsEnabled : (map['notifications'] == true);
        _disciplineProgram = map['disciplineProgram']?.toString() ?? _disciplineProgram;
        _username = map['username']?.toString() ?? _username;
        _email = map['email']?.toString() ?? _email;
        _age = map['age'] is int ? map['age'] as int : (map['age'] != null ? int.tryParse(map['age'].toString()) : null);
      }
    } catch (e) {
      // ignore and keep defaults
    }
    notifyListeners();
  }

  Future<void> _save() async {
    final map = {
      'theme': _theme,
      'language': _language,
      'analytics': _analyticsEnabled,
      'notifications': _notificationsEnabled,
      'disciplineProgram': _disciplineProgram,
      'username': _username,
      'email': _email,
      'age': _age,
    };
    await _db.saveMap('settings', map);
  }

  void setTheme(String value) {
    _theme = value;
    _save();
    notifyListeners();
  }

  void setLanguage(String localeCode) {
    _language = localeCode;
    _save();
    notifyListeners();
  }

  void setAnalyticsEnabled(bool enabled) {
    _analyticsEnabled = enabled;
    _save();
    notifyListeners();
  }

  void setDisciplineProgram(String program) {
    _disciplineProgram = program;
    _save();
    notifyListeners();
  }

  void setNotificationsEnabled(bool enabled) {
    _notificationsEnabled = enabled;
    _save();
    notifyListeners();
  }

  void setAccountInfo({String? username, String? email, int? age}) {
    if (username != null) _username = username;
    if (email != null) _email = email;
    if (age != null) _age = age;
    _save();
    notifyListeners();
  }
}
