import 'package:first_flutter_project/widgets/background_image.dart';
import 'package:first_flutter_project/widgets/custom_button.dart';
import 'package:first_flutter_project/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final Color customColor = const Color.fromARGB(255, 103, 167, 235);
  final String description =
      'This application will help you monitor '
      'temperature, humidity, and CO2 levels. '
      'If the minimum or maximum set parameters '
      'are violated, an alarm will be sent.';

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
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/',
                              (route) => true,
                            );
                          },
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
