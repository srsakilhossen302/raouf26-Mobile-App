import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:raouf26mobileapp/Utils/theme_controller.dart';

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({super.key});

  @override
  State<AccessibilityPage> createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  bool isContrastEnabled = true;
  final themeController = ThemeController.instance;

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
          'app_accessibility'.tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Container(
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
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAccessibilityItem(
                title: 'contrast'.tr,
                subtitle: 'contrast_desc'.tr,
                icon: Icons.contrast_rounded,
                value: isContrastEnabled,
                onChanged: (val) => setState(() => isContrastEnabled = val),
                isDarkMode: isDarkMode,
              ),
              Divider(
                height: 1,
                indent: 64.w,
                endIndent: 16.w,
                color: isDarkMode
                    ? Colors.white10
                    : Colors.grey.withOpacity(0.1),
              ),
              Obx(
                () => _buildAccessibilityItem(
                  title: 'dark_mode_title'.tr,
                  subtitle: 'dark_mode_desc'.tr,
                  icon: Icons.dark_mode_outlined,
                  value: themeController.isDarkMode.value,
                  onChanged: (val) => themeController.toggleTheme(),
                  isDarkMode: isDarkMode,
                  showBetaTag: true,
                  isLast: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccessibilityItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDarkMode,
    bool showBetaTag = false,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : const Color(0xFFF5F7FA),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                      ),
                    ),
                    if (showBetaTag) ...[
                      SizedBox(width: 10.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode ? const Color(0xFF4A80F0).withOpacity(0.2) : Colors.black,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'beta'.tr,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w800,
                            color: isDarkMode ? const Color(0xFF4A80F0) : Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    color: isDarkMode ? Colors.white60 : Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Switch.adaptive(
            value: value,
            activeColor: const Color(0xFF4A80F0),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

}
