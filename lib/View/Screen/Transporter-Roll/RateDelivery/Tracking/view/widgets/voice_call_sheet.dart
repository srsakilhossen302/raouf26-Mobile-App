import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/transporter_tracking_controller.dart';


class VoiceCallSheet extends StatefulWidget {
  final TrackingPackageModel package;

  const VoiceCallSheet({super.key, required this.package});

  @override
  State<VoiceCallSheet> createState() => _VoiceCallSheetState();
}

class _VoiceCallSheetState extends State<VoiceCallSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isMuted = false;
  bool isSpeakerOn = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A), // Dark Navy
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Stack(
        children: [
          // Background Glow
          Positioned(
            top: -100.h,
            left: -100.w,
            child: Container(
              width: 300.w,
              height: 300.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF4A80F0).withOpacity(0.1),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60.h),
                // Pulsating Avatar
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 140.w + (20.w * _controller.value),
                          height: 140.w + (20.w * _controller.value),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF4A80F0).withOpacity(
                                1 - _controller.value,
                              ),
                              width: 2,
                            ),
                          ),
                        ),
                        Container(
                          width: 120.w,
                          height: 120.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(widget.package.userImage),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: Colors.white24,
                              width: 4,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 32.h),
                // Name & Status
                Text(
                  widget.package.userName,
                  style: GoogleFonts.manrope(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Calling...",
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    color: Colors.white60,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(),
                // Call Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlBtn(
                      isMuted ? Icons.mic_off : Icons.mic,
                      "Mute",
                      isMuted,
                      () => setState(() => isMuted = !isMuted),
                    ),
                    _buildControlBtn(
                      Icons.dialpad,
                      "Keypad",
                      false,
                      () {},
                    ),
                    _buildControlBtn(
                      isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                      "Speaker",
                      isSpeakerOn,
                      () => setState(() => isSpeakerOn = !isSpeakerOn),
                    ),
                  ],
                ),
                SizedBox(height: 60.h),
                // End Call Button
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444), // Red
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFEF4444).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.call_end_rounded,
                      color: Colors.white,
                      size: 32.sp,
                    ),
                  ),
                ),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlBtn(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? const Color(0xFF0F172A) : Colors.white,
              size: 24.sp,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 12.sp,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}

void showVoiceCallSheet(BuildContext context, TrackingPackageModel package) {
  Get.bottomSheet(
    VoiceCallSheet(package: package),
    isScrollControlled: true,
    enableDrag: false,
    barrierColor: Colors.black54,
  );
}
