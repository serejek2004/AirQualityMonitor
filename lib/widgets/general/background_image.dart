import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.network(
        'https://w0.peakpx.com/wallpaper/486/247/HD-wallpaper-forest-landscapes-mountain-mountains-woods-autumn-mount-landscape-rocky.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
