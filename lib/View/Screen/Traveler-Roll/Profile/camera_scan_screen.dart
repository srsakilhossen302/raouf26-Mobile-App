import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class CameraScanScreen extends StatelessWidget {
  const CameraScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Simulated Camera Preview
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey[900],
              child: Icon(Icons.camera_alt_outlined, color: Colors.white24, size: 100.sp),
            ),
          ),
          
          // Overlay
          _buildOverlay(context),
          
          // Controls
          Positioned(
            top: 50.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.flash_on_rounded, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          
          Positioned(
            bottom: 60.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'position_document_frame'.tr,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.photo_library_outlined, color: Colors.white, size: 28),
                      onPressed: () {},
                    ),
                    Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(4.w),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.flip_camera_ios_outlined, color: Colors.white, size: 28),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return ColorFiltered(
      overlayColor: Colors.black.withOpacity(0.5),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              backgroundBlendMode: BlendMode.dstOut,
            ),
          ),
          Center(
            child: Container(
              width: 320.w,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorFiltered extends StatelessWidget {
  final Color overlayColor;
  final Widget child;

  const ColorFiltered({super.key, required this.overlayColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        IgnorePointer(
          child: Container(
            color: overlayColor,
          ),
        ),
      ],
    );
  }
}
