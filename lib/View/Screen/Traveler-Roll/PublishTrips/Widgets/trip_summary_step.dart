import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../publish_trip_flow_controller.dart';

class TripSummaryStep extends StatelessWidget {
  final PublishTripFlowController controller;
  final bool isDarkMode;

  const TripSummaryStep({
    super.key,
    required this.controller,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Publish Your Trip",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          Text(
            "List your journey and accept delivery requests from trusted senders.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24.h),
          // Calendar View summary (simplified)
          _buildSummaryCard(controller, isDarkMode),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: _buildSummaryBox(
                  "Departure & Destination",
                  "Tunisia",
                  Icons.location_on,
                  isDarkMode,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  children: [
                    _buildSummaryMiniBox(
                      "Set Price & Capacity",
                      "Price / kg",
                      isDarkMode,
                    ),
                    SizedBox(height: 12.h),
                    _buildSummaryMiniBox(
                      "Set Travel Details",
                      "e.g. flight, boat etc.",
                      isDarkMode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(PublishTripFlowController controller, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "February, 2026",
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
            ],
          ),
          SizedBox(height: 16.h),
          // Add a simple representation of a calendar or the summary bar
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String title, String value, IconData icon, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF4A80F0), size: 20),
          SizedBox(height: 12.h),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryMiniBox(String title, String hint, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(fontSize: 10.sp, color: Colors.grey),
          ),
          SizedBox(height: 4.h),
          Text(
            hint,
            style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
