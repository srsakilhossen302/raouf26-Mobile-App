import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'cancellation_request_page.dart';
import 'cancellation_not_available_page.dart';

class TransportAgreementSuccessPage extends StatelessWidget {
  final bool isDarkMode;
  const TransportAgreementSuccessPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          "Success",
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Success Checkmark Icon with Concentric Circles
              Center(
                child: Container(
                  width: 140.w,
                  height: 140.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF4A80F0).withOpacity(0.05),
                  ),
                  child: Center(
                    child: Container(
                      width: 110.w,
                      height: 110.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF4A80F0).withOpacity(0.1),
                      ),
                      child: Center(
                        child: Container(
                          width: 85.w,
                          height: 85.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF4A80F0),
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 45.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              // Title
              Text(
                "Agreement Signed!",
                style: GoogleFonts.manrope(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 12.h),

              // Subtitle
              Text(
                "Your transport agreement has been successfully signed and updated in your profile.",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: isDarkMode ? Colors.white70 : Colors.grey,
                  height: 1.5,
                ),
              ),

              const Spacer(flex: 3),

              // Agreement Council Button
              _buildActionButton(
                "Agreement cancelation request",
                const Color(0xFF4A80F0),
                Colors.white,
                onPressed: () {
                  // Static check for demonstration (we'll integrate backend later)
                  bool hasActiveItems = false;

                  if (hasActiveItems) {
                    Get.to(
                      () =>
                          CancellationNotAvailablePage(isDarkMode: isDarkMode),
                    );
                  } else {
                    Get.to(
                      () => CancellationRequestPage(isDarkMode: isDarkMode),
                    );
                  }
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    Color bgColor,
    Color textColor, {
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
