import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackbar {
  static void show({
    required String title,
    required String message,
    bool isError = false,
    bool isSuccess = false,
    bool isWarning = false,
  }) {
    Color iconColor;
    IconData iconData;

    if (isError) {
      iconColor = const Color(0xFFFF4D4D); // Red
      iconData = Icons.error_outline_rounded;
    } else if (isSuccess) {
      iconColor = const Color(0xFF00C853); // Green
      iconData = Icons.check_circle_outline_rounded;
    } else if (isWarning) {
      iconColor = const Color(0xFFFF9800); // Orange
      iconData = Icons.warning_amber_rounded;
    } else {
      iconColor = const Color(0xFF4A80F0); // Primary Blue
      iconData = Icons.info_outline_rounded;
    }

    bool isDarkMode = Get.isDarkMode;

    Get.rawSnackbar(
      titleText: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.manrope(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      icon: Container(
        margin: EdgeInsets.only(left: 16.w, right: 8.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: iconColor,
          size: 24.sp,
        ),
      ),
      backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      borderRadius: 16.r,
      snackPosition: SnackPosition.TOP,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.08),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
      barBlur: 10,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 400),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutCirc,
      reverseAnimationCurve: Curves.easeInCirc,
    );
  }

  static void success({required String title, required String message}) {
    show(title: title, message: message, isSuccess: true);
  }

  static void error({required String title, required String message}) {
    show(title: title, message: message, isError: true);
  }

  static void warning({required String title, required String message}) {
    show(title: title, message: message, isWarning: true);
  }

  static void info({required String title, required String message}) {
    show(title: title, message: message);
  }
}
