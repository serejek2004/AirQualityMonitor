import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:flutter/material.dart';

Widget buildButtons(BuildContext context) {
  const Color customColor = Color.fromARGB(255, 103, 167, 235);

    return Row(
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
    );
  }
