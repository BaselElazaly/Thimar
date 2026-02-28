import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveToken(String token) async {
    return await sharedPreferences.setString('token', token);
  }

  static String getToken() {
    return sharedPreferences.getString('token') ?? "";
  }

  static Future<bool> clearToken() async {
    return await sharedPreferences.remove('token');
  }

  static Future<bool> saveData({required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static String getData({required String key}) {
    return sharedPreferences.getString(key) ?? "";
  }
}