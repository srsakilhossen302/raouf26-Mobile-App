import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  final RxBool isDarkMode = false.obs;
  static const String _key = 'isDarkMode';

  @override
  void onInit() {
    super.onInit();
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool(_key) ?? false;
  }

  Future<void> toggleTheme() async {
    await setTheme(!isDarkMode.value);
  }

  Future<void> setTheme(bool dark) async {
    isDarkMode.value = dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, dark);
    Get.changeThemeMode(dark ? ThemeMode.dark : ThemeMode.light);
  }

  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
}
