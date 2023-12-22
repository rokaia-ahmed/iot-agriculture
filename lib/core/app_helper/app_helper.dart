import 'package:flutter/material.dart';

class AppHelper {
  /// PHYSICS LIST VIEW
  static BouncingScrollPhysics scroll = const BouncingScrollPhysics();

  /// CLOSE KEYBOARD
  static Future closeKeyboard() async {
    /// CLOSE KEYBOARD
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
