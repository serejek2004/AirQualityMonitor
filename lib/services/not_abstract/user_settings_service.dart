import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsService {
  static const _minTemperatureKey = 'minTemperature';
  static const _maxTemperatureKey = 'maxTemperature';
  static const _minHumidityKey = 'minHumidity';
  static const _maxHumidityKey = 'maxHumidity';

  Future<void> initializeDefaultSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final String? login = prefs.getString('sessionLogin');
    
    if (prefs.getDouble(_minTemperatureKey + login.toString()) == null) {
      await prefs.setDouble(_minTemperatureKey + login.toString(), 5);
      await prefs.setDouble(_maxTemperatureKey + login.toString(), 25);
      await prefs.setDouble(_minHumidityKey + login.toString(), 20);
      await prefs.setDouble(_maxHumidityKey + login.toString(), 80);
    }
  }

  Future<Map<String, double>> getUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final String? login = prefs.getString('sessionLogin');

    final minTemperature = prefs.getDouble(
      _minTemperatureKey + login.toString(),
    ) ?? 10.0;
    final maxTemperature = prefs.getDouble(
      _maxTemperatureKey + login.toString(),
    ) ?? 20.0;
    final minHumidity = prefs.getDouble(
      _minHumidityKey + login.toString(),
    ) ?? 20.0;
    final maxHumidity = prefs.getDouble(
      _maxHumidityKey + login.toString(),
    ) ?? 80.0;

    return {
      'minTemperature': minTemperature,
      'maxTemperature': maxTemperature,
      'minHumidity': minHumidity,
      'maxHumidity': maxHumidity,
    };
  }

  Future<void> setMinTemperature(double value, String login) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_minTemperatureKey, value);
  }

  Future<void> setMaxTemperature(double value, String login) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_maxTemperatureKey + login, value);
  }

  Future<void> setMinHumidity(double value, String login) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_minHumidityKey + login, value);
  }

  Future<void> setMaxHumidity(double value, String login) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_maxHumidityKey + login, value);
  }
}
