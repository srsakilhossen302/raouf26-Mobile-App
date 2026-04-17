import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';

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

class _RoleTransitionScreenState extends State<RoleTransitionScreen> {
  @override
  void initState() {
    super.initState();
    // Show transition for 2 seconds then navigate
    Future.delayed(const Duration(seconds: 2), () {
      widget.onComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            widget.isSwitchingToTransporter
                ? "assets/images/Home-img2.png"
                : "assets/images/Home-img-1.png",
            fit: BoxFit.cover,
          ),
          
          // Overlay Content
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     // Logo
          //     SvgPicture.asset(
          //       AppIcons.logo,
          //       width: 150.w,
          //       colorFilter: ColorFilter.mode(
          //         widget.isSwitchingToTransporter ? Colors.black : Colors.black, // Logo in black as requested
          //         BlendMode.srcIn,
          //       ),
          //     ),
          //     SizedBox(height: 24.h),
              
          //     // Transition Text
          //     Text(
          //       widget.isSwitchingToTransporter
          //           ? 'switching_to_transporter'.tr
          //           : 'Switching to Traveler',
          //       style: GoogleFonts.plusJakartaSans(
          //         fontSize: 20.sp,
          //         fontWeight: FontWeight.w700,
          //         color: Colors.white, // Text in white as requested
          //       ),
          //     ),
          //     SizedBox(height: 12.h),
              
          //     // Loading indicator
          //     const SizedBox(
          //       width: 40,
          //       child: LinearProgressIndicator(
          //         backgroundColor: Colors.white24,
          //         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
