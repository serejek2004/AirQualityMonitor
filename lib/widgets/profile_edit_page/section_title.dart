import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final Color color;

  const SectionTitle({
    required this.title,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        CustomText(
          title: title,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          textColor: color,
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
