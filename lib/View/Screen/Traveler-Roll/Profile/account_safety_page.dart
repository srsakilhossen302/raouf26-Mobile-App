import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';

import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/email_verification_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/change_pin_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/trusted_devices_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/login_history_page.dart';
import 'package:raouf26mobileapp/View/Screen/VerifyIdentityScreen/verify_identity_screen.dart';

class AccountSafetyPage extends StatelessWidget {
  const AccountSafetyPage({super.key});

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
          'account_safety'.tr,
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
            // Protection Status Card
            _buildProtectionStatusCard(isDarkMode),
            SizedBox(height: 24.h),

            // Security Preferences
            _buildSectionTitle('security_preferences'.tr, isDarkMode),
            SizedBox(height: 12.h),
            _buildSectionCard(
              isDarkMode: isDarkMode,
              items: [
                // _buildMenuItem(
                //   'kyc_verification'.tr,
                //   Icons.verified_user_rounded,
                //   isDarkMode,
                //   onTap: () => Get.to(() => const VerifyIdentityScreen()),
                // ),
                _buildMenuItem(
                  'update_email'.tr,
                  Icons.mail_outline_rounded,
                  isDarkMode,
                  onTap: () => Get.to(() => const EmailVerificationPage()),
                ),
                _buildMenuItem(
                  'change_pin'.tr,
                  Icons.more_horiz_rounded,
                  isDarkMode,
                  onTap: () => Get.to(() => const ChangePinPage()),
                ),
                _buildSwitchItem(
                  'face_recognition'.tr,
                  Icons.face_unlock_rounded,
                  true,
                  (val) {},
                  isDarkMode,
                ),
                _buildSwitchItem(
                  'biometric_login'.tr,
                  Icons.fingerprint_rounded,
                  true,
                  (val) {},
                  isDarkMode,
                ),
                _buildSwitchItem(
                  'two_layers_protection'.tr,
                  Icons.shield_outlined,
                  true,
                  (val) {},
                  isDarkMode,
                  isLast: true,
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Other Features
            _buildSectionTitle('other_features'.tr, isDarkMode),
            SizedBox(height: 12.h),
            _buildSectionCard(
              isDarkMode: isDarkMode,
              items: [
                _buildMenuItem(
                  'trusted_devices'.tr,
                  Icons.devices_rounded,
                  isDarkMode,
                  onTap: () => Get.to(() => const TrustedDevicesPage()),
                ),
                _buildMenuItem(
                  'login_history'.tr,
                  Icons.history_rounded,
                  isDarkMode,
                  onTap: () => Get.to(() => const LoginHistoryPage()),
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

  Widget _buildProtectionStatusCard(bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60.w,
                height: 60.w,
                child: CircularProgressIndicator(
                  value: 0.25,
                  strokeWidth: 6.w,
                  backgroundColor: isDarkMode
                      ? Colors.white10
                      : const Color(0xFFF5F7FA),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF4A80F0),
                  ),
                ),
              ),
              Text(
                "25%",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'account_protection_status'.tr,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'protection_status_desc'.tr,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: isDarkMode ? Colors.white70 : Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required List<Widget> items,
    required bool isDarkMode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData icon,
    bool isDarkMode, {
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : const Color(0xFFF5F7FA),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 18.sp,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            size: 18.sp,
            color: isDarkMode ? Colors.white38 : Colors.grey[400],
          ),
        ),
        if (!isLast)
          Divider(
            indent: 56.w,
            endIndent: 16.w,
            height: 1,
            color: isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.1),
          ),
      ],
    );
  }

  Widget _buildSwitchItem(
    String title,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
    bool isDarkMode, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : const Color(0xFFF5F7FA),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 18.sp,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          trailing: Switch.adaptive(
            value: value,
            activeColor: const Color(0xFF4A80F0),
            onChanged: onChanged,
          ),
        ),
        if (!isLast)
          Divider(
            indent: 56.w,
            endIndent: 16.w,
            height: 1,
            color: isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.1),
          ),
      ],
    );
  }
}
