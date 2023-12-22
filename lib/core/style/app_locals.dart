import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Default locale is index 0
///
///   * Use [supportedLocales] of [0] for default locale, or [1] for second locale ...
///   * Get the number of locales by using [supportedLocales.length].
///   * Get Current locale by using [currentLocale].
///
///   Example:
/// ```dart
/// AppLocales.setLocale(AppLocales.supportedLocales[AppLocales.supportedLocales.length - 1]);
///  --OR--
/// supportedLocales = AppLocales.supportedLocales;
/// AppLocales.setLocale(supportedLocales[supportedLocales.length - 1]);
///
/// --either way--
/// print(AppLocales.currentLocale.value.languageCode); //prints 'en'
/// ```

class AppLocales {
  static String path = 'assets/translations';

  /// list of supported locales
  static const supportedLocales = [
    Locale('ar', 'EG'),
    Locale('en', 'US'),
  ];

  /// list of supported locales names
  static const supportedLocalesNames = [
    'العربية',
    'English',
  ];

  /// list of supported locales codes
  static const supportedLocalesCodes = [
    'ar',
    'en',
  ];

  /// current app locale
  static Locale currentLocale = supportedLocales[0];

  /// updates device locale, takes [context] and [index] of supported locales as parameters
  ///
  /// * [index] is the index of supported locales in [supportedLocales]
  ///
  /// * [context] is the current [BuildContext].
  static void setDeviceLocale(BuildContext context, int index) {
    //make sure the index is in range
    if (index < 0 || index >= supportedLocales.length) {
      return;
    }
    EasyLocalization.of(context)!
        .setLocale(supportedLocales[index])
        .then((value) => currentLocale = supportedLocales[index]);
  }
}
