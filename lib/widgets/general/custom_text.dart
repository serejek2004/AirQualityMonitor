import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? title;
  final FontWeight fontWeight;
  final double fontSize;
  final Color textColor;
  final TextAlign textAlign;

  const CustomText({
    required this.title,
    required this.fontWeight,
    required this.fontSize,
    required this.textColor,
    this.textAlign = TextAlign.left,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toString(),
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Times New Roman',
        color: textColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
