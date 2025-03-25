import 'package:first_flutter_project/widgets/background_image.dart';
import 'package:first_flutter_project/widgets/custom_button.dart';
import 'package:first_flutter_project/widgets/custom_input.dart';
import 'package:first_flutter_project/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final Color customColor = const Color.fromARGB(255, 103, 167, 235);

  const LoginPage({super.key});

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
                    title: 'Login',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    textColor: customColor,
                  ),
                  const SizedBox(height: 5),
                  CustomInput(
                    label: 'Login',
                    obscureText: false,
                    fieldWidth: 350,
                    textColor: customColor,
                    cursorColor: customColor,
                    focusedBorderColor: customColor,
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    title: 'Password',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    textColor: customColor,
                  ),
                  const SizedBox(height: 5),
                  CustomInput(
                    label: 'Password',
                    obscureText: true,
                    fieldWidth: 350,
                    textColor: customColor,
                    cursorColor: customColor,
                    focusedBorderColor: customColor,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    buttonText: 'Login',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false,
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
          ),
        ],
      ),
    );
  }
}
