import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class LoginHistoryPage extends StatelessWidget {
  const LoginHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FB),
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
          'login_history_title'.tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            _buildHistoryItem(
              deviceName: "Redmi Note 12 Pro",
              location: "Tunis, Tunisia",
              time: "Today, 10:30 AM",
              statusColor: Colors.green,
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 16.h),
            _buildHistoryItem(
              deviceName: "Chrome on Windows 11",
              location: "Tunis, Tunisia",
              time: "Yesterday, 01:45 PM",
              statusColor: Colors.green,
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 16.h),
            _buildHistoryItem(
              deviceName: "Unknown Device",
              location: "London, UK",
              time: "Yesterday, 04:25 PM",
              statusColor: Colors.red,
              isDarkMode: isDarkMode,
              isFailed: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem({
    required String deviceName,
    required String location,
    required String time,
    required Color statusColor,
    required bool isDarkMode,
    bool isFailed = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
              shape: BoxShape.circle,
            ),
            child: Icon(
              deviceName.contains("Chrome") ? Icons.laptop_windows_rounded : Icons.smartphone_rounded,
              size: 20.sp,
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        deviceName,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  "$location • $time",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: isDarkMode ? Colors.white70 : Colors.grey[600],
                  ),
                ),
                if (isFailed) ...[
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      "Attempt failed",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
