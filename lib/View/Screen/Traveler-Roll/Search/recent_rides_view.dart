import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../Utils/AppIcons/app_icons.dart';

class RecentRidesView extends StatelessWidget {
  const RecentRidesView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDarkMode ? Colors.white : Colors.black87,
            size: 20.sp,
          ),
        ),
        title: Text(
          "Recent Rides",
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            _recentRideItem("Tunis", "Paris", "14 Jan", "2:30 PM", isDarkMode),
            SizedBox(height: 12.h),
            _recentRideItem("Tunis", "Maseille", "14 Jan", "2:30 PM", isDarkMode),
            SizedBox(height: 12.h),
            _recentRideItem("Tunis", "Rome", "14 Jan", "2:30 PM", isDarkMode),
            SizedBox(height: 12.h),
            _recentRideItem("Tunis", "London", "14 Jan", "2:30 PM", isDarkMode),
            SizedBox(height: 12.h),
            _recentRideItem("Tunis", "Italy", "14 Jan", "2:30 PM", isDarkMode),
            SizedBox(height: 12.h),
            _recentRideItem("Tunis", "Berlin", "13 Jan", "11:30 AM", isDarkMode),
            SizedBox(height: 12.h),
            _recentRideItem("Tunis", "Madrid", "12 Jan", "09:15 AM", isDarkMode),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _recentRideItem(
    String from,
    String to,
    String date,
    String time,
    bool isDarkMode,
  ) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : const Color(0xFFF9FAFB),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.history, color: Colors.grey, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      from,
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.arrow_forward,
                      size: 14.sp,
                      color: isDarkMode ? Colors.white54 : Colors.black87,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      to,
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  "$date  •  $time",
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
