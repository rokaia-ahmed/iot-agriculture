import 'package:flutter/material.dart';
import 'package:iot_agriculture/core/style/app_radius.dart';
import 'package:iot_agriculture/views/widgets/widgets.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height = 50.0,
    this.width = double.infinity,
    required this.function,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
  });

  final Function() function;
  final String text;
  final double height;
  final double width;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        function();
      },
      color: backgroundColor,
      // elevation: 5.0,
      height: height,
      minWidth: width,
      elevation: 0.0,
      focusElevation: 0.0,
      hoverElevation: 0.0,
      highlightElevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.radius12,
      ),
      child: Text(
        text,
        style: mainTextStyle(
          color: textColor,
          size: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
