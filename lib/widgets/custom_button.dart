import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;

  const CustomButton({
    required this.buttonText,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontFamily: 'Times New Roman',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
