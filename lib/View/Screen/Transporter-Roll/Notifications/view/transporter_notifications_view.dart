import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/transporter_notifications_controller.dart';

class TransporterNotificationsView extends StatelessWidget {
  const TransporterNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransporterNotificationsController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: const Color(0xFF4A80F0),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notifications",
                            style: GoogleFonts.montserrat(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(
                              Icons.close,
                              color: isDarkMode ? Colors.white : Colors.black,
                              size: 28.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        children: [
                          Container(
                            padding: EdgeInsets.all(20.r),
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              children: [
                                _buildNotificationItem(
                                  "Trip Completed",
                                  "Tunis \u2192 Paris",
                                  "2h ago",
                                  Icons.check,
                                  isDarkMode,
                                  true,
                                ),
                                Divider(height: 30.h, color: isDarkMode ? Colors.white10 : Colors.grey.shade200),
                                _buildNotificationItem(
                                  "New Message",
                                  "From Client",
                                  "5h ago",
                                  Icons.mail_outline,
                                  isDarkMode,
                                  true,
                                ),
                                Divider(height: 30.h, color: isDarkMode ? Colors.white10 : Colors.grey.shade200),
                                _buildNotificationItem(
                                  "New Message",
                                  "From Client",
                                  "8h ago",
                                  Icons.mail_outline,
                                  isDarkMode,
                                  false,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, String time, IconData iconData, bool isDarkMode, bool isUnread) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white12 : Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              if (!isDarkMode)
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                )
            ],
          ),
          child: Icon(
            iconData,
            color: isDarkMode ? Colors.white70 : Colors.black54,
            size: 18.sp,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
            ),
            SizedBox(height: 8.h),
            if (isUnread)
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
