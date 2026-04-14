import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class CompliancePage extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool isDarkMode;

  const CompliancePage({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Info Icon & Close Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Icon(Icons.info_outline, size: 22.sp, color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, size: 28.sp, color: isDarkMode ? Colors.white : Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 40.h),

              // Title
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 16.h),

              // Description
              Text(
                description,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15.sp,
                  color: Colors.grey[600],
                  height: 1.6,
                ),
              ),
              const Spacer(),

              // The 3D Illustration Image
              Center(
                child: Image.asset(
                  "assets/images/Verify Your Account- img.png",
                  width: 280.w,
                  height: 280.w,
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A80F0),
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    buttonText,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
