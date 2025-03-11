import 'package:first_flutter_project/pages/homePage.dart';
import 'package:first_flutter_project/pages/loginPage.dart';
import 'package:first_flutter_project/pages/profileEditPage.dart';
import 'package:first_flutter_project/pages/profilePage.dart';
import 'package:first_flutter_project/pages/registrationPage.dart';
import 'package:first_flutter_project/pages/welcomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.blueAccent),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => WelcomePage(),
      '/login': (context) => LoginPage(),
      '/home': (context) => HomePage(),
      '/registration': (context) => RegistrationPage(),
      '/profile': (context) => ProfilePage(),
      '/profileEdit': (context) => ProfileEditPage(),
    },
  ),
  );
}
