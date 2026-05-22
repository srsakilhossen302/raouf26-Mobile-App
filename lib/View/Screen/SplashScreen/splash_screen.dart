import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../OnboardingScreen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _breathingController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _rotationAnimation;

  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Entrance animation controller (elastic scale, rotation, fade-in)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Springy elastic scale-up entrance animation
    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    // Elegant initial rotation settling down
    _rotationAnimation = Tween<double>(begin: -0.15, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    // Smooth fade-in
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // 2. Continuous breathing & floating animation controller
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Gentle pulse scale between 0.93 and 1.07
    _pulseAnimation = Tween<double>(begin: 0.93, end: 1.07).animate(
      CurvedAnimation(
        parent: _breathingController,
        curve: Curves.easeInOut,
      ),
    );

    // Smooth vertical floating between -6px and 6px
    _floatAnimation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(
        parent: _breathingController,
        curve: Curves.easeInOut,
      ),
    );

    // Start entrance, then run the looping breath/float
    _controller.forward().then((_) {
      _breathingController.repeat(reverse: true);
    });

    // 3 seconds transition to OnboardingScreen
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => const OnboardingScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            "assets/images/Home-img-1.png",
            fit: BoxFit.cover,
          ),

          // Content Layer containing the animating center logo
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([_controller, _breathingController]),
              builder: (context, child) {
                final entranceScale = _scaleAnimation.value;
                final pulseScale = _pulseAnimation.value;
                final rotation = _rotationAnimation.value;
                final opacity = _opacityAnimation.value;
                final floatOffset = _floatAnimation.value;

                return Transform.translate(
                  offset: Offset(0, floatOffset),
                  child: Transform.scale(
                    scale: entranceScale * (entranceScale >= 1.0 ? pulseScale : 1.0),
                    child: Transform.rotate(
                      angle: rotation,
                      child: Opacity(
                        opacity: opacity,
                        child: SvgPicture.asset(
                          "assets/icons/Logo2.svg",
                          width: 75.w,
                          height: 75.w,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
