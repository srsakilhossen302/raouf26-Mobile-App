import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';

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
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            // Success Checkmark Icon
            Container(
              width: 140.w,
              height: 140.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF4A80F0).withOpacity(0.1),
              ),
              child: Center(
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF4A80F0),
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 60.sp),
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // Title
            Text(
              "Your Trip Is Live!",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),

            // Subtitle
            Text(
              "Your trip is now live and visible to senders looking\nfor delivery help.",
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                color: Colors.grey,
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
              onPressed: () => Get.back(),
            ),
            SizedBox(height: 12.h),
            _buildActionButton(
              "Share on Facebook",
              Colors.white,
              Colors.black,
              AppIcons.facebook,
              isOutline: true,
              onPressed: () {},
            ),
            SizedBox(height: 12.h),
            _buildActionButton(
              "Share on WhatsApp",
              Colors.white,
              Colors.black,
              AppIcons.whatsapp,
              isOutline: true,
              onPressed: () {},
            ),
            SizedBox(height: 12.h),
            _buildActionButton(
              "Share Link",
              Colors.white,
              Colors.black,
              null,
              iconData: Icons.ios_share,
              isOutline: true,
              onPressed: () {},
            ),
            SizedBox(height: 32.h),
          ],
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
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 16.h),
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
              iconPath.endsWith('.svg')
                  ? SvgPicture.asset(iconPath, width: 20.w, height: 20.w)
                  : Image.asset(iconPath, width: 20.w, height: 20.w),
              SizedBox(width: 10.w),
            ],
            if (iconData != null) ...[
              Icon(iconData, color: textColor, size: 20.sp),
              SizedBox(width: 10.w),
            ],
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
