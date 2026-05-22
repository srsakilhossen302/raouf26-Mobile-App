import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String _roleKey = "user_role";
  static String? _cachedRole;

  // Save Role
  static Future<void> saveUserRole(String role) async {
    try {
      _cachedRole = role;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_roleKey, role);
    } catch (e) {
      print("Error saving role: $e");
    }
  }

  // Get Role (synchronous check)
  static String getCachedUserRole() {
    return _cachedRole ?? "Traveler";
  }

  // Get Role
  static Future<String?> getUserRole() async {
    if (_cachedRole != null) return _cachedRole;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _cachedRole = prefs.getString(_roleKey);
      return _cachedRole;
    } catch (e) {
      print("Error getting role: $e");
      return null;
    }
  }

  // Clear All
  static Future<void> clearAll() async {
    try {
      _cachedRole = null;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      print("Error clearing preferences: $e");
    }
  }
}
