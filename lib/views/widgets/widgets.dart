import 'package:flutter/material.dart';

TextStyle mainTextStyle({
  required Color color,
  required double size,
  required FontWeight fontWeight,
}) {
  return TextStyle(
    fontFamily: 'Montserrat',
    color: color,
    fontSize: size,
    fontWeight: fontWeight,
  );
}
