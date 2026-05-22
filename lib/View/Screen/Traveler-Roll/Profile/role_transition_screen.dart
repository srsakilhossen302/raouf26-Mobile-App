import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleTransitionScreen extends StatefulWidget {
  final bool isSwitchingToTransporter;
  final VoidCallback onComplete;

  const RoleTransitionScreen({
    super.key,
    required this.isSwitchingToTransporter,
    required this.onComplete,
  });

  @override
  State<RoleTransitionScreen> createState() => _RoleTransitionScreenState();
}

class _RoleTransitionScreenState extends State<RoleTransitionScreen>
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

    // Hold transition for 2.5 seconds to showcase premium animation, then complete
    Future.delayed(const Duration(milliseconds: 2500), () {
      widget.onComplete();
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
          // Background rendering
          if (widget.isSwitchingToTransporter)
            // Big Full-Page SVG background logo for Transporter
            SvgPicture.asset(
              "assets/icons/Home.svg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
          else
            Image.asset(
              "assets/images/Home-img-1.png",
              fit: BoxFit.cover,
            ),

          // Content Layer containing the animating center logo and transition text
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),

                // Stunning micro-animated center logo
                AnimatedBuilder(
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
                              widget.isSwitchingToTransporter
                                  ? "assets/icons/Logo.svg"
                                  : "assets/icons/Logo2.svg",
                              width: 75.w,
                              height: 75.w,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const Spacer(flex: 2),

                // Premium typography transition text
                Text(
                  widget.isSwitchingToTransporter
                      ? 'switching_to_transporter'.tr
                      : 'Switching to Traveler',
                  style: GoogleFonts.manrope(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: widget.isSwitchingToTransporter
                        ? Colors.black
                        : Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 16.h),

                const Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
