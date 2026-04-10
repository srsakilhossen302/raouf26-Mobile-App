import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../OnboardingScreen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // ৩ সেকেন্ড পর OnboardingScreen-এ যাবে
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => const OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Home.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
