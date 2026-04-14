import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/camera_scan_screen.dart';

class ScanDocumentPage extends StatelessWidget {
  final String docType;

  const ScanDocumentPage({super.key, required this.docType});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FB),
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
          docType,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // Scanning Tips
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Colors.blue,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'scanning_tips'.tr,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _buildTipItem('Ensure good lighting', isDarkMode),
            _buildTipItem('Place document on flat surface', isDarkMode),
            _buildTipItem('All corners must be visible', isDarkMode),
            _buildTipItem('Text must be readable', isDarkMode),

            SizedBox(height: 32.h),

            // Illustration
            Center(
              child: Container(
                width: double.infinity,
                height: 180.h,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: SvgPicture.asset(
                    AppIcons.passportImg,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            SizedBox(height: 32.h),

            // Scan Slots
            if (docType == 'passport'.tr) ...[
              _buildScanSlot('scan_passport'.tr, isDarkMode),
            ] else ...[
              _buildScanSlot('scan_cin_front'.tr, isDarkMode),
              SizedBox(height: 16.h),
              _buildScanSlot('scan_cin_back'.tr, isDarkMode),
            ],

            SizedBox(height: 40.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CameraScanScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'scan_document'.tr,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String tip, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4.h),
            width: 6.w,
            height: 6.w,
            decoration: const BoxDecoration(
              color: Color(0xFF4A80F0),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              tip.tr,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                color: isDarkMode ? Colors.white70 : Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanSlot(String label, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          height: 140.h,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              if (!isDarkMode)
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Get.to(() => const CameraScanScreen()),
              borderRadius: BorderRadius.circular(16.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A80F0).withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: const Color(0xFF4A80F0),
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'tap_to_scan'.tr,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4A80F0),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'No document scanned yet',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
