import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:iot_agriculture/core/constants/images.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,

      /// CIRCLES BACKGROUND
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: Svg(AppImage.circleBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
