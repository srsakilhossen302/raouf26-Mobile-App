import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'View/Screen/SplashScreen/splash_screen.dart';
import 'Utils/Localizations/app_translations.dart';
import 'Utils/locale_controller.dart';
import 'Utils/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // Load saved locale or use system default
  String? savedLocaleCode = prefs.getString('locale');
  Locale? initialLocale;
  if (savedLocaleCode != null) {
    List<String> codes = savedLocaleCode.split('_');
    initialLocale = Locale(codes[0], codes[1]);
  } else {
    initialLocale = Get.deviceLocale;
  }

  // Initialize Controllers
  Get.put(LocaleController());
  Get.put(ThemeController());

  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  final Locale? initialLocale;
  const MyApp({super.key, this.initialLocale});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.instance;

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(
          () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Raouf 26 App',
            translations: AppTranslations(),
            locale: initialLocale ?? const Locale('en', 'US'),
            fallbackLocale: const Locale('en', 'US'),
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: child!,
              );
            },
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF4A80F0),
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            themeMode: themeController.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF121212),
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF4A80F0),
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
