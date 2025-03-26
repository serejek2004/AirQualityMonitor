import 'package:first_flutter_project/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final double minValue;
  final double maxValue;

  const ProfileInfoRow({
    required this.label,
    required this.minValue,
    required this.maxValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: '$label: $minValue - $maxValue',
      fontSize: 22,
      fontWeight: FontWeight.w600,
      textColor: const Color.fromARGB(209, 103, 167, 235),
    );
  }
}
