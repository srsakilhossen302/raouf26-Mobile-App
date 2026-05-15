import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../Controllers/publish_trip_flow_controller.dart';

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
            style: GoogleFonts.manrope(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          Text(
            "List your journey and accept delivery requests from trusted senders.",
            style: GoogleFonts.manrope(
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
                child: Obx(
                  () => _buildSummaryBox(
                    "Departure & Destination",
                    controller.departureText.value.isEmpty || controller.destinationText.value.isEmpty
                        ? "Not set"
                        : "${controller.departureText.value} → ${controller.destinationText.value}",
                    Icons.location_on,
                    isDarkMode,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  children: [
                    Obx(
                      () => _buildSummaryMiniBox(
                        "Set Price & Capacity",
                        controller.pricePerPackageText.value.isEmpty || controller.capacityText.value.isEmpty
                            ? "Price / kg"
                            : "${controller.pricePerPackageText.value} ${controller.selectedCurrency.value} - ${controller.capacityText.value} kg",
                        isDarkMode,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(
                      () => _buildSummaryMiniBox(
                        "Set Travel Details",
                        controller.travelDetailsSummary.value.isEmpty
                            ? "e.g. flight, boat etc."
                            : controller.travelDetailsSummary.value,
                        isDarkMode,
                      ),
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

  Widget _buildSummaryCard(
    PublishTripFlowController controller,
    bool isDarkMode,
  ) {
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
              Obx(
                () => Text(
                  controller.selectedDate.value != null
                      ? DateFormat('MMMM, yyyy').format(controller.selectedDate.value!)
                      : "Date not set",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
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

  Widget _buildSummaryBox(
    String title,
    String value,
    IconData icon,
    bool isDarkMode,
  ) {
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
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.manrope(
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
            style: GoogleFonts.manrope(
              fontSize: 10.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            hint,
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
