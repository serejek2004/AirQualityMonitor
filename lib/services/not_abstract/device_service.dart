import 'package:shared_preferences/shared_preferences.dart';

class DeviceService {
  Future<void> saveDeviceId(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('sessionLogin');
    await prefs.setString('${login}IdDevice', deviceId);
  }

  Future<void> tempSaveDeviceId(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('sessionLogin');
    await prefs.setString('${login}TempIdDevice', deviceId);
  }

  Future<String?> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('sessionLogin');
    return prefs.getString('${login}IdDevice');
  }

  Future<bool> isDevice() async {
    final deviceId = await getDeviceId();
    return deviceId != null;
  }

  Future<void> tempDeleteDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('sessionLogin');
    await prefs.remove('${login}TempIdDevice');
  }

  Future<void> disconnect() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('sessionLogin');
    await prefs.remove('${login}IdDevice');
  }
}
