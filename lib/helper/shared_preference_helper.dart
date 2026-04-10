import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String _roleKey = "user_role";

  // Save Role
  static Future<void> saveUserRole(String role) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_roleKey, role);
    } catch (e) {
      print("Error saving role: $e");
    }
  }

  // Get Role
  static Future<String?> getUserRole() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_roleKey);
    } catch (e) {
      print("Error getting role: $e");
      return null;
    }
  }

  // Clear All
  static Future<void> clearAll() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      print("Error clearing preferences: $e");
    }
  }
}
