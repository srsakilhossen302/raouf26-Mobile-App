import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String _roleKey = "user_role";

  // Save Role
  static Future<bool> saveUserRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_roleKey, role);
  }

  // Get Role
  static Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  // Clear All
  static Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
