import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/verification_status_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/scan_document_page.dart';

class DocumentVerificationPage extends StatelessWidget {
  const DocumentVerificationPage({super.key});

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
          'documents_verification'.tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),

            // Verification Status Card
            _buildStatusCard(isDarkMode),

            SizedBox(height: 24.h),

            // Why Verify Section
            _buildWhyVerifySection(isDarkMode),

            SizedBox(height: 24.h),

            // Identity Documents
            _buildSectionTitle(
              'identity_documents'.tr,
              'Upload at least one identity document.',
              isDarkMode,
            ),
            SizedBox(height: 16.h),
            _buildDocumentList(
              isDarkMode: isDarkMode,
              items: [
                _buildDocItem(
                  'passport'.tr,
                  AppIcons.passport,
                  isDarkMode,
                  onTap: () =>
                      Get.to(() => ScanDocumentPage(docType: 'passport'.tr)),
                ),
                _buildDocItem(
                  'cin_id_card'.tr,
                  AppIcons.cinIdCard,
                  isDarkMode,
                  onTap: () =>
                      Get.to(() => ScanDocumentPage(docType: 'cin_id_card'.tr)),
                ),
                _buildDocItem(
                  'driving_license'.tr,
                  AppIcons.drivingLicense,
                  isDarkMode,
                  onTap: () => Get.to(
                    () => ScanDocumentPage(docType: 'driving_license'.tr),
                  ),
                  isLast: true,
                ),
              ],
            ),

            SizedBox(height: 32.h),

            // Transporter Documents
            _buildSectionTitle(
              'transporter_documents'.tr,
              'Required for professional transporter activity.',
              isDarkMode,
            ),
            SizedBox(height: 16.h),
            _buildDocumentList(
              isDarkMode: isDarkMode,
              items: [
                _buildDocItem(
                  'vehicle_registration'.tr,
                  AppIcons.vehicleRegistration,
                  isDarkMode,
                  onTap: () => Get.to(
                    () => ScanDocumentPage(docType: 'vehicle_registration'.tr),
                  ),
                ),
                _buildDocItem(
                  'residence_certificate'.tr,
                  AppIcons.documentsIcon,
                  isDarkMode,
                  onTap: () => Get.to(
                    () => ScanDocumentPage(docType: 'residence_certificate'.tr),
                  ),
                  isLast: true,
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(0xFF1E1E1E)
            : const Color(0xFFF0F7FF), // Light blue background
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_rounded,
                color: const Color(0xFF4A80F0),
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'not_verified'.tr,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Upload your document to verify your identity and build trust with other users.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const VerificationStatusPage()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A80F0),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'get_verified'.tr,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyVerifySection(bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'why_verify_identity'.tr,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 20.h),
          _buildWhyItem(
            'build_trust'.tr,
            'Verified users are more trusted by the community.',
            isDarkMode,
          ),
          SizedBox(height: 16.h),
          _buildWhyItem(
            'more_opportunities'.tr,
            'Get priority in matching with transporters and travelers.',
            isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildWhyItem(String title, String desc, bool isDarkMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Container(
            width: 5.w,
            height: 5.w,
            decoration: const BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                desc,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, String subtitle, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentList({
    required List<Widget> items,
    required bool isDarkMode,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildDocItem(
    String title,
    String iconPath,
    bool isDarkMode, {
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
          leading: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : const Color(0xFFF5F7FA),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              iconPath,
              width: 20.sp,
              height: 20.sp,
              colorFilter: ColorFilter.mode(
                isDarkMode ? Colors.white70 : Colors.black87,
                BlendMode.srcIn,
              ),
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            size: 20.sp,
            color: isDarkMode ? Colors.white38 : Colors.grey[400],
          ),
        ),
        if (!isLast)
          Padding(
            padding: EdgeInsets.only(left: 76.w, right: 20.w),
            child: Divider(
              height: 1,
              color: isDarkMode
                  ? Colors.white10
                  : Colors.grey.withOpacity(0.05),
            ),
          ),
      ],
    );
  }
}
