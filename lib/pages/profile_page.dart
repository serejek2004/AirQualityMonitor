import 'package:first_flutter_project/services/abstract/user_service.dart';
import 'package:first_flutter_project/services/not_abstract/local_user_service.dart';
import 'package:first_flutter_project/services/not_abstract/user_settings_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/profile_page_widgets/buttons.dart';
import 'package:first_flutter_project/widgets/profile_page_widgets/greeting_user.dart';
import 'package:first_flutter_project/widgets/profile_page_widgets/profile_info_row.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserService userService = LocalUserService();
  final UserSettingsService userSettingsService = UserSettingsService();
  Map<String, double>? settings;
  String? login;

  final Color customColor = const Color.fromARGB(255, 103, 167, 235);

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final setLogin = prefs.getString('sessionLogin');
    final settingsData = await userSettingsService.getUserSettings();

    setState(() {
      login = setLogin;
      settings = settingsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: settings == null
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildGreeting(login),
                        const SizedBox(height: 40),
                        ProfileInfoRow(
                          label: 'Temperature', 
                          minValue: settings!['minTemperature'], 
                          maxValue: settings!['maxTemperature'],
                        ),
                        const SizedBox(height: 20),
                        ProfileInfoRow(
                          label: 'Humidity', 
                          minValue: settings!['minHumidity'], 
                          maxValue: settings!['maxHumidity'],
                        ),
                        const SizedBox(height: 20),
                        ProfileInfoRow(
                          label: 'CO2', 
                          minValue: settings!['minCO2'], 
                          maxValue: settings!['maxCO2'],
                        ),
                        const SizedBox(height: 40),
                        buildButtons(context),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
