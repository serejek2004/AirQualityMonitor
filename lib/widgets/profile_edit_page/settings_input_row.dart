import 'package:first_flutter_project/widgets/general/custom_input.dart';
import 'package:flutter/material.dart';

class SettingsInputRow extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final String label1;
  final String label2;
  final Color color;

  const SettingsInputRow({
    required this.controller1,
    required this.controller2,
    required this.label1,
    required this.label2,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomInput(
            controller: controller1,
            label: label1,
            obscureText: false,
            fieldWidth: 150,
            textColor: color,
            cursorColor: color,
            focusedBorderColor: color,
          ),
          CustomInput(
            controller: controller2,
            label: label2,
            obscureText: false,
            fieldWidth: 150,
            textColor: color,
            cursorColor: color,
            focusedBorderColor: color,
          ),
        ],
      ),
    );
  }
}
