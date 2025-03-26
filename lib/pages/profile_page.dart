import 'package:first_flutter_project/widgets/background_image.dart';
import 'package:first_flutter_project/widgets/custom_button.dart';
import 'package:first_flutter_project/widgets/custom_text.dart';
import 'package:first_flutter_project/widgets/profile_info_row.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color customColor = const Color.fromARGB(255, 103, 167, 235);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: 'Welcome USER_EMAIL!',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    textColor: customColor,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  const ProfileInfoRow(
                    label: 'Temperature', 
                    minValue: 10, 
                    maxValue: 30,
                  ),
                  const SizedBox(height: 20),
                  const ProfileInfoRow(
                    label: 'Humidity',
                    minValue: 20, 
                    maxValue: 60,
                  ),
                  const SizedBox(height: 20),
                  const ProfileInfoRow(
                    label: 'CO2',
                    minValue: 15, 
                    maxValue: 50,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        buttonText: 'Profile edit',
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/profileEdit',
                            (route) => true,
                          );
                        },
                        width: 150,
                        height: 50,
                        backgroundColor: customColor,
                        textColor: Colors.black,
                      ),
                      CustomButton(
                        buttonText: 'Home',
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
