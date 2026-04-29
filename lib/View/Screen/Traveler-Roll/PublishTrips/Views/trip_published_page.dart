import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/PublishTrips/Views/publish_trips_screen.dart';

class TripPublishedPage extends StatelessWidget {
  final bool isDarkMode;
  const TripPublishedPage({super.key, required this.isDarkMode});

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
          "Trip Published",
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
                "Your Trip Is Live!",
                style: GoogleFonts.manrope(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 12.h),

              // Subtitle
              Text(
                "Your trip is now live and visible to senders looking\nfor delivery help.",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: isDarkMode ? Colors.white70 : Colors.grey,
                  height: 1.5,
                ),
              ),
              
              const Spacer(flex: 3),

              // Action Buttons
              _buildActionButton(
                "View Trip Details",
                const Color(0xFF4A80F0),
                Colors.white,
                null,
                onPressed: () {
                  Get.offAll(() => const PublishTripsScreen(), arguments: 1);
                },
              ),
              SizedBox(height: 12.h),
              _buildActionButton(
                "Share on Facebook",
                isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
                isDarkMode ? Colors.white : Colors.black,
                AppIcons.facebook,
                isOutline: true,
                onPressed: () {},
              ),
              SizedBox(height: 12.h),
              _buildActionButton(
                "Share on WhatsApp",
                isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
                isDarkMode ? Colors.white : Colors.black,
                AppIcons.whatsapp,
                isOutline: true,
                onPressed: () {},
              ),
              SizedBox(height: 12.h),
              _buildActionButton(
                "Share Link",
                isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
                isDarkMode ? Colors.white : Colors.black,
                null,
                iconData: Icons.ios_share,
                isOutline: true,
                onPressed: () {},
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
    Color textColor,
    String? iconPath, {
    IconData? iconData,
    bool isOutline = false,
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
            side: isOutline
                ? BorderSide(color: Colors.grey.withOpacity(0.2))
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              SvgPicture.asset(
                iconPath,
                width: 24.w,
                height: 24.w,
                colorFilter: label == "View Trip Details" 
                  ? null 
                  : ColorFilter.mode(
                      const Color(0xFF4A80F0), // Use blue for Facebook/WhatsApp icons as seen in many modern apps or keep original
                      BlendMode.srcIn
                    ),
              ),
              SizedBox(width: 12.w),
            ],
            if (iconData != null) ...[
              Icon(iconData, color: isDarkMode ? Colors.white : Colors.black87, size: 20.sp),
              SizedBox(width: 12.w),
            ],
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
