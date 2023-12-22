import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// METHOD SHOW TOAST
Future toast({
  required String msg,
  required Color color,
}) async {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class AppDialog {
  /// method show toast message
  static Future toast({
    required String msg,
    required Color color,
  }) async {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
