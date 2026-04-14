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
    autoDetectLocale();
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
}
