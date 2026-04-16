import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ActiveParcelsPage extends StatelessWidget {
  const ActiveParcelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          "Active Requests",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildRequestCard(
            name: "Ahmad B.",
            time: "5 hrs ago",
            status: "Pending",
            fromCity: "Tunis",
            fromDate: "14 Jan",
            fromTime: "08:30 AM",
            toCity: "Paris",
            toDate: "14 Jan",
            toTime: "10:45 PM",
            packageSize: "Medium (15kg)",
            packageStatus: "Urgent",
            estimate: "€25",
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 24.h),
          _buildRequestCard(
            name: "Sarah L.",
            time: "1 day ago",
            status: "Pending",
            fromCity: "London",
            fromDate: "16 Jan",
            fromTime: "10:00 AM",
            toCity: "Berlin",
            toDate: "18 Jan",
            toTime: "06:00 PM",
            packageSize: "Small (5kg)",
            packageStatus: "Normal",
            estimate: "€15",
            isDarkMode: isDarkMode,
            isNormal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard({
    required String name,
    required String time,
    required String status,
    required String fromCity,
    required String fromDate,
    required String fromTime,
    required String toCity,
    required String toDate,
    required String toTime,
    required String packageSize,
    required String packageStatus,
    required String estimate,
    required bool isDarkMode,
    bool isNormal = false,
  }) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // 1. Header Box
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: const NetworkImage(
                    "https://i.pravatar.cc/150?u=a042581f4e29026704d",
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.verified, color: const Color(0xFF4A80F0), size: 14.sp),
                      ],
                    ),
                    Text(
                      time,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color(0xFFF59E0B).withOpacity(0.1)
                        : const Color(0xFFFFF7ED),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFFF59E0B),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // 2. Route Box
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Icon(Icons.near_me_outlined, size: 14.sp, color: Colors.grey.shade600),
                    ),
                    Container(
                      height: 26.h,
                      width: 1,
                      color: Colors.grey.withOpacity(0.3), // Simple line for now
                    ),
                    Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Icon(Icons.location_on_outlined, size: 14.sp, color: Colors.grey.shade600),
                    ),
                  ],
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fromCity,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: isDarkMode ? Colors.white : Colors.black87,
                                ),
                              ),
                              Text(
                                fromDate,
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            fromTime,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                toCity,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: isDarkMode ? Colors.white : Colors.black87,
                                ),
                              ),
                              Text(
                                toDate,
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            toTime,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // 3. Package Details Box
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                _detailRow("Package Size", packageSize, false, null, isDarkMode),
                Divider(height: 24.h, color: Colors.grey.withOpacity(0.1)),
                _detailRow("Status", "", true, packageStatus, isDarkMode, isNormal: isNormal),
                Divider(height: 24.h, color: Colors.grey.withOpacity(0.1)),
                _detailRow("Total Estimate", estimate, false, null, isDarkMode, isBold: true),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // 4. Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: Text(
                    "Reject",
                    style: GoogleFonts.montserrat(
                      color: Colors.red.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A80F0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    elevation: 0,
                  ),
                  child: Text(
                    "Accept",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, bool isPill, String? pillText, bool isDarkMode, {bool isBold = false, bool isNormal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (isPill && pillText != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: isNormal
                  ? (isDarkMode ? Colors.green.withOpacity(0.1) : const Color(0xFFECFDF5))
                  : (isDarkMode ? Colors.red.withOpacity(0.1) : const Color(0xFFFEF2F2)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              pillText,
              style: GoogleFonts.montserrat(
                color: isNormal ? Colors.green.shade600 : Colors.red.shade400,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else
          Text(
            value,
            style: GoogleFonts.montserrat(
              color: isDarkMode ? Colors.white : Colors.black87,
              fontSize: 13.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
