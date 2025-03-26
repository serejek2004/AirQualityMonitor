import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.network(
        'https://surl.li/pfiagj',
        fit: BoxFit.cover,
      ),
    );
  }
}
