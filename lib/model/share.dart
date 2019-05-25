import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static void saveLastLogin(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_login', userId);
  }

  static void saveID(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_login_id', id);
  }

  static void saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('login_name', name);
  }

  static Future<String> loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('login_name'));
  }


  static Future<String> loadLastId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('last_login_id'));
  }

  static Future<String> loadLastLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('last_login'));
  }

}