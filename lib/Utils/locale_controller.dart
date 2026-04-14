import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  static LocaleController get instance => Get.find();

  final Rx<Locale> currentLocale = const Locale('en', 'US').obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedLocaleCode = prefs.getString('locale');
    if (savedLocaleCode != null) {
      List<String> codes = savedLocaleCode.split('_');
      currentLocale.value = Locale(codes[0], codes[1]);
    } else {
      currentLocale.value = Get.deviceLocale ?? const Locale('en', 'US');
    }
  }

  Future<void> changeLocale(String code, String country) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', '${code}_$country');
    currentLocale.value = Locale(code, country);
    Get.updateLocale(currentLocale.value);
  }
}
