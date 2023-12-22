import 'package:flutter/material.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';

ThemeData appLightTheme = ThemeData(
  fontFamily: 'custom_font',
  primaryColor: primary,
  useMaterial3: false,
  scaffoldBackgroundColor: white,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primary,
    secondary: primary,
  ),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,

  /// APP BAR THEME
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: black),
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontFamily: 'custom_font',
      fontWeight: FontWeight.bold,
      color: black,
    ),
    elevation: 0.0,
    // centerTitle: true,
    titleSpacing: 20.0,
    backgroundColor: white,
  ),

  /// BOTTOM NAV BAR THEME
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0.0,
    type: BottomNavigationBarType.fixed,
    backgroundColor: white,
    selectedItemColor: primary,
    unselectedItemColor: grey,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 0),
  ),

  /// DRAWER
  drawerTheme: const DrawerThemeData(
    elevation: 0.0,
    backgroundColor: white,
  ),
);
