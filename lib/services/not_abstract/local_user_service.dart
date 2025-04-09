import 'package:first_flutter_project/services/abstract/user_service.dart';
import 'package:first_flutter_project/services/not_abstract/user_settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUserService implements UserService {
  static const _loginKey = 'login';
  static const _passwordKey = 'password';
  static const _sessionLoginKey = 'sessionLogin';
  static const _sessionPasswordKey = 'sessionPassword';

  final UserSettingsService _settingsService = UserSettingsService();

  @override
  Future<bool> registerUser(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final existingLogin = prefs.getString(_loginKey + login);

    if (existingLogin != null) {
      return false;
    }

    await prefs.setString(_loginKey + login, login);
    await prefs.setString(_passwordKey + login, password);
    await prefs.setString(_sessionLoginKey, login);
    await prefs.setString(_sessionPasswordKey, password);

    await _settingsService.initializeDefaultSettings();

    return true;
  }

  @override
  Future<Map<String, String>?> getUser(String login_) async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString(_loginKey + login_);
    final password = prefs.getString(_passwordKey + login_);

    if (login != null && password != null) {
      return {
        'login': login,
        'password': password,
      };
    } else {
      return null;
    }
  }

  @override
  Future<bool> validateUser(String login, String password) async {
    final user = await getUser(login);

    if (user == null) {
      return false;
    }

    if (user['login'] == login && user['password'] == password) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_sessionLoginKey, login);
      await prefs.setString(_sessionPasswordKey, password);
      return true;
    }
    else {
      return false;
    }
  }
}
