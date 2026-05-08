import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  static LocaleController get instance => Get.find();

  // Supported languages
  static const List<String> _supportedLanguages = ['en', 'ar', 'fr'];

  // Default locale
  static const Locale _defaultLocale = Locale('en', 'US');

  final Rx<Locale> currentLocale = _defaultLocale.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLangCode = prefs.getString('languageCode');
    final savedCountryCode = prefs.getString('countryCode');

    if (savedLangCode != null && _supportedLanguages.contains(savedLangCode)) {
      currentLocale.value = Locale(savedLangCode, savedCountryCode ?? '');
      Get.updateLocale(currentLocale.value);
    } else {
      autoDetectLocale();
    }
  }

  void autoDetectLocale() {
    Locale? deviceLocale = Get.deviceLocale;
    
    if (deviceLocale != null) {
      String languageCode = deviceLocale.languageCode.toLowerCase();
      
      if (_supportedLanguages.contains(languageCode)) {
        if (languageCode == 'ar') {
          currentLocale.value = const Locale('ar', 'AR');
        } else if (languageCode == 'fr') {
          currentLocale.value = const Locale('fr', 'FR');
        } else {
          currentLocale.value = const Locale('en', 'US');
        }
      } else {
        // Fallback to English
        currentLocale.value = _defaultLocale;
      }
    } else {
      currentLocale.value = _defaultLocale;
    }
    
    // Apply locale
    Get.updateLocale(currentLocale.value);
  }

  Future<void> changeLocale(String langCode, String countryCode) async {
    if (_supportedLanguages.contains(langCode)) {
      final locale = Locale(langCode, countryCode);
      currentLocale.value = locale;
      Get.updateLocale(locale);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('languageCode', langCode);
      await prefs.setString('countryCode', countryCode);
    }
  }
}
