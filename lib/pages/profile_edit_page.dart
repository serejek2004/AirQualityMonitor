import 'package:first_flutter_project/widgets/background_image.dart';
import 'package:first_flutter_project/widgets/custom_button.dart';
import 'package:first_flutter_project/widgets/custom_input.dart';
import 'package:first_flutter_project/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  final Color customColor = const Color.fromARGB(255, 103, 167, 235);

  Widget _buildInputRow(String label1, String label2) {
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomInput(
            label: label1,
            obscureText: false,
            fieldWidth: 150,
            textColor: customColor,
            cursorColor: customColor,
            focusedBorderColor: customColor,
          ),
          CustomInput(
            label: label2,
            obscureText: false,
            fieldWidth: 150,
            textColor: customColor,
            cursorColor: customColor,
            focusedBorderColor: customColor,
          ),
        ],
      ),
    );
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    title: 'New temperature',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    textColor: Color.fromARGB(255, 103, 167, 235),
                  ),
                  const SizedBox(height: 5),
                  _buildInputRow('Min temperature', 'Max temperature'),

                  const CustomText(
                    title: 'New humidity',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    textColor: Color.fromARGB(255, 103, 167, 235),
                  ),
                  const SizedBox(height: 5),
                  _buildInputRow('Min humidity', 'Max humidity'),

                  const CustomText(
                    title: 'New CO2',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    textColor: Color.fromARGB(255, 103, 167, 235),
                  ),
                  const SizedBox(height: 5),
                  _buildInputRow('Min CO2', 'Max CO2'),

                  const SizedBox(height: 20),
                  CustomButton(
                    buttonText: 'Update',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/profile',
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
