import 'package:first_flutter_project/widgets/background_image.dart';
import 'package:first_flutter_project/widgets/custom_button.dart';
import 'package:first_flutter_project/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {

  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {  
  final Color customColor = const Color.fromARGB(255, 103, 167, 235);

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
                    title: 'Welcome!', 
                    fontWeight: FontWeight.w600, 
                    fontSize: 50, 
                    textColor: customColor,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        buttonText: 'Login',
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        },
                        width: 150,
                        height: 50,
                        backgroundColor: customColor,
                        textColor: Colors.black,
                      ),
                      const SizedBox(width: 50),
                      CustomButton(
                        buttonText: 'Registration',
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/registration',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
