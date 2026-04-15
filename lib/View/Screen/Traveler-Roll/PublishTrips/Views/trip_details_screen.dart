import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Utils/AppIcons/app_icons.dart';
import '../Models/trip_model.dart';

class TripDetailsScreen extends StatelessWidget {
  final TripModel trip;

  const TripDetailsScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: Icon(
              Icons.more_vert,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            onSelected: (value) {
              if (value == 0) {
                // Handle Report an issue
              } else if (value == 1) {
                // Handle Contact support
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.report_problem_outlined,
                      size: 20.sp,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "report_an_issue".tr,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.headset_mic_outlined,
                      size: 20.sp,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "contact_support".tr,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        title: Text(
          "Trip Details",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  _buildDetailsCard(
                    title: "Route Details",
                    isDarkMode: isDarkMode,
                    child: Column(
                      children: [
                        _buildRoutePoint(
                          icon: AppIcons.departure,
                          city: trip.departureCity,
                          date: trip.departureDate,
                          time: trip.departureTime,
                          isFirst: true,
                          isDarkMode: isDarkMode,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              AppIcons.partion,
                              height: 30.h,
                              colorFilter: ColorFilter.mode(
                                isDarkMode
                                    ? Colors.white24
                                    : const Color(0xFFE0E0E0),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        _buildRoutePoint(
                          icon: AppIcons.location,
                          city: trip.arrivalCity,
                          date: trip.arrivalDate,
                          time: trip.arrivalTime,
                          isFirst: false,
                          isDarkMode: isDarkMode,
                        ),
                        SizedBox(height: 20.h),
                        const Divider(),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Stops",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? Colors.white38
                                    : const Color(0xFF9E9E9E),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                trip.stops,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xFF1A1A1A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildDetailsCard(
                    title: "Trip Details",
                    isDarkMode: isDarkMode,
                    child: Column(
                      children: [
                        _buildDetailRow(
                          "Departure Date & Time",
                          "${trip.departureDate}, ${trip.departureTime}",
                          isDarkMode,
                        ),
                        _buildDetailRow(
                          "Arrival Date & Time",
                          "${trip.arrivalDate}, ${trip.arrivalTime}",
                          isDarkMode,
                        ),
                        _buildDetailRow(
                          "Maximum Weight Available:",
                          trip.maxWeight,
                          isDarkMode,
                        ),
                        _buildDetailRow(
                          "Price Per kg",
                          trip.pricePerKg,
                          isDarkMode,
                        ),
                        _buildDetailRow(
                          "Travel Mode",
                          trip.travelMode,
                          isDarkMode,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A80F0),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Complete Trip",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      side: const BorderSide(color: Color(0xFFFFEAEA)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Delete Trip",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFF3B3B),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard({
    required String title,
    required Widget child,
    required bool isDarkMode,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                ),
              ),
              SvgPicture.asset(
                AppIcons.edit,
                width: 20.w,
                height: 20.w,
                colorFilter: ColorFilter.mode(
                  isDarkMode ? Colors.white60 : Colors.black54,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          child,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                color: isDarkMode ? Colors.white38 : const Color(0xFF9E9E9E),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutePoint({
    required String icon,
    required String city,
    required String date,
    required String time,
    required bool isFirst,
    required bool isDarkMode,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(0xFF2C2C2C)
                : const Color(0xFFF5F7FA),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            icon,
            width: 16.w,
            height: 16.w,
            colorFilter: ColorFilter.mode(
              isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                ),
              ),
              Text(
                date,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  color: isDarkMode ? Colors.white60 : const Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white70 : const Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}
