import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManageAccountPage extends StatelessWidget {
  const ManageAccountPage({super.key});

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
          'manage_account'.tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildManageItem(
              title: 'delete_account'.tr,
              icon: "assets/icons/Delete Account.svg",
              isDarkMode: isDarkMode,
              onTap: () => _showDeleteConfirmationDialog(context, isDarkMode),
              fallbackIcon: Icons.delete_outline_rounded,
            ),
            SizedBox(height: 16.h),
            _buildManageItem(
              title: 'switch_account'.tr,
              icon: "assets/icons/Switch Account.svg",
              isDarkMode: isDarkMode,
              onTap: () {
                // Handle switch account
              },
              fallbackIcon: Icons.swap_horiz_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManageItem({
    required String title,
    required String icon,
    required bool isDarkMode,
    required VoidCallback onTap,
    required IconData fallbackIcon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
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
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : const Color(0xFFF8F9FB),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: _buildIcon(icon, fallbackIcon, isDarkMode),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: isDarkMode ? Colors.grey : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(
    String iconPath,
    IconData fallbackIcon,
    bool isDarkMode, {
    double? size,
  }) {
    // Check if SVG exists - for now we'll use a simple logic: if path contains ".svg" and we don't have it, use fallback.
    // In a real app, you might use a more sophisticated check or assume assets are bundled.
    // Since I know they are not in the list from the LS tool, I'll use the fallback for now.

    // For this implementation, I'll use the fallback since the files aren't in the project.
    return Icon(
      fallbackIcon,
      size: size ?? 20.sp,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, bool isDarkMode) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.05)
                      : const Color(0xFFF8F9FB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: _buildIcon(
                    "assets/icons/Delete Account.svg",
                    Icons.delete_outline_rounded,
                    isDarkMode,
                    size: 32.sp,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'delete_your_account_q'.tr,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                'delete_account_desc'.tr,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        side: BorderSide(
                          color: isDarkMode
                              ? Colors.grey[700]!
                              : Colors.grey[300]!,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'cancel'.tr,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle actual deletion logic here
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF2D2D),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'delete_account'.tr,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
