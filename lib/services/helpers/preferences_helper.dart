import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, String?>> getLoginAndTempId() async {
  final prefs = await SharedPreferences.getInstance();
  final login = prefs.getString('sessionLogin');
  final tempId = prefs.getString('${login}TempIdDevice');
  return {'login': login, 'tempId': tempId};
}
