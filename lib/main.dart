import 'package:first_flutter_project/pages/home_page.dart';
import 'package:first_flutter_project/pages/login_page.dart';
import 'package:first_flutter_project/pages/profile_edit_page.dart';
import 'package:first_flutter_project/pages/profile_page.dart';
import 'package:first_flutter_project/pages/registration_page.dart';
import 'package:first_flutter_project/pages/welcome_page.dart';
import 'package:first_flutter_project/services/abstract/user_service.dart';
import 'package:first_flutter_project/services/not_abstract/local_user_service.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/services/not_abstract/user_settings_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String initialRoute = await _getInitialRoute();

  runApp(
    MultiProvider(
      providers: [
        Provider<UserService>(
          create: (_) => LocalUserService(),
        ),
        Provider<UserSettingsService>(
          create: (_) => UserSettingsService(),
        ),
        ChangeNotifierProvider<NetworkService>(
          create: (_) => NetworkService(),
        ),
      ],
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
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
