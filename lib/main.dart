import 'package:first_flutter_project/pages/home_page.dart';
import 'package:first_flutter_project/pages/login_page.dart';
import 'package:first_flutter_project/pages/profile_edit_page.dart';
import 'package:first_flutter_project/pages/profile_page.dart';
import 'package:first_flutter_project/pages/registration_page.dart';
import 'package:first_flutter_project/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.blueAccent),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const WelcomePage(),
      '/login': (context) => const LoginPage(),
      '/home': (context) => const HomePage(),
      '/registration': (context) => const RegistrationPage(),
      '/profile': (context) => const ProfilePage(),
      '/profileEdit': (context) => const ProfileEditPage(),
    },
  ),
  );
}
