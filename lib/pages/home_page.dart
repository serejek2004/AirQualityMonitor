import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final Color customColor = const Color.fromARGB(255, 103, 167, 235);
  final String description =
      'This application will help you monitor '
      'temperature, humidity, and CO2 levels. '
      'If the minimum or maximum set parameters '
      'are violated, an alarm will be sent.';

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionLogin');
    await prefs.remove('sessionPassword');
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    title: 'Air quality monitor',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    textColor: customColor,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    child: CustomText(
                      title: description,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      textColor: customColor,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          buttonText: 'Profile',
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/profile',
                              (route) => true,
                            );
                          },
                          width: 150,
                          height: 50,
                          backgroundColor: customColor,
                          textColor: Colors.black,
                        ),
                        CustomButton(
                          buttonText: 'Logout',
                          onPressed: () => _logout(context),
                          width: 150,
                          height: 50,
                          backgroundColor: customColor,
                          textColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
