import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';

Widget buildGreeting(String? login) {
  const Color customColor = Color.fromARGB(255, 103, 167, 235);

  return Center(
    child: CustomText(
      title: 'Hello $login!',
      fontSize: 28,
      fontWeight: FontWeight.w600,
      textColor: customColor,
      textAlign: TextAlign.center,
    ),
  );
}
