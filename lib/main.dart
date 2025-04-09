import 'package:first_flutter_project/pages/home_page.dart';
import 'package:first_flutter_project/pages/login_page.dart';
import 'package:first_flutter_project/pages/profile_edit_page.dart';
import 'package:first_flutter_project/pages/profile_page.dart';
import 'package:first_flutter_project/pages/registration_page.dart';
import 'package:first_flutter_project/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String initialRoute = await _getInitialRoute();
  
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.blueAccent),
    debugShowCheckedModeBanner: false,
    initialRoute: initialRoute,
    routes: {
      '/welcome': (context) => const WelcomePage(),
      '/login': (context) => const LoginPage(),
      '/home': (context) => const HomePage(),
      '/registration': (context) => const RegistrationPage(),
      '/profile': (context) => const ProfilePage(),
      '/profileEdit': (context) => const ProfileEditPage(),
    },
  ),
  );
}

Future<String> _getInitialRoute() async {
  final prefs = await SharedPreferences.getInstance();
  final sessionLogin = prefs.getString('sessionLogin');
  final sessionPassword = prefs.getString('sessionPassword');

  if (sessionLogin != null && sessionPassword != null) {
    return '/home';
  }

  return '/welcome';
}
