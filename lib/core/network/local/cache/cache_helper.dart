import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  /// OBJECT FROM PACKAGE
  static late SharedPreferences sharedPreferences;

  /// GET INSTANCE FROM SHARED PREFERENCES
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// SAVE DATA IN CACHE
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return sharedPreferences.setString(key, value);
    if (value is int) return sharedPreferences.setInt(key, value);
    if (value is bool) return sharedPreferences.setBool(key, value);

    return sharedPreferences.setDouble(key, value as double);
  }

  /// GET DATA FROM CACHE
  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  /// REMOVE DATA FROM CACHE BY KEY
  static Future<bool> removeData({
    required String key,
  }) async {
    return sharedPreferences.remove(key);
  }

  /// SAVE DATA IN CACHE
  static Future<bool> saveMapData({
    required Map<String, dynamic> data,
  }) async {
    try {
      data.forEach((key, value) {
        if (value is String) sharedPreferences.setString(key, value);
        if (value is int) sharedPreferences.setInt(key, value);
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
