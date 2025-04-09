import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final bool obscureText;
  final double fieldWidth;
  final Color textColor;
  final Color cursorColor;
  final Color focusedBorderColor;
  final TextEditingController? controller; 
  final TextInputType? keyboardType; 

  const CustomInput({
    required this.label,
    required this.obscureText,
    required this.fieldWidth,
    required this.textColor,
    required this.cursorColor,
    required this.focusedBorderColor,
    this.controller, 
    this.keyboardType, 
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fieldWidth,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        autocorrect: false,
        keyboardType: keyboardType ?? TextInputType.text,
        style: TextStyle(
          color: textColor,
        ),
        cursorColor: cursorColor,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: textColor,
            fontFamily: 'Times New Roman',
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: focusedBorderColor,
            ),
          ),
        ),
      ),
    );
  }
}
