import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../MessagesScreen/chat_view.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

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
                // Handle Cancel booking
              } else if (value == 2) {
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
                      Icons.cancel_outlined,
                      size: 20.sp,
                      color: Colors.redAccent,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "cancel_booking".tr,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.support_agent_outlined,
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
          "booking_details".tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            // Success message
            _buildSuccessMessage(isDarkMode),
            SizedBox(height: 24.h),

            // Booking Status Card
            _buildBookingStatus(isDarkMode),
            SizedBox(height: 16.h),

            // Client Info Card
            _buildClientInfo(isDarkMode),
            SizedBox(height: 16.h),

            // Parcel Information Card
            _buildParcelInfo(isDarkMode),
            SizedBox(height: 16.h),

            // Route Details Card
            _buildRouteDetails(isDarkMode),
            SizedBox(height: 16.h),

            // Payment Details Card
            _buildPaymentDetails(isDarkMode),
            SizedBox(height: 40.h),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF121212) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A80F0),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              "pickup".tr,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessMessage(bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9EB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE1F3D8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: const BoxDecoration(
              color: Color(0xFF67C23A),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: Colors.white, size: 16.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "accepted".tr,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "welcome_subtitle".tr,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    color: const Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingStatus(bool isDarkMode) {
    return _buildCard(
      title: "Booking Details",
      isDarkMode: isDarkMode,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStepLabel("Booked", true),
              _buildStepLabel("Picked Up", false),
              _buildStepLabel("In Transit", false),
              _buildStepLabel("Delivered", false),
            ],
          ),
          SizedBox(height: 12.h),
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(height: 2.h, color: const Color(0xFFE0E0E0)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStepDot(true),
                  _buildStepDot(false),
                  _buildStepDot(false),
                  _buildStepDot(false),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepLabel(String label, bool isActive) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 12.sp,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
        color: isActive ? const Color(0xFF1A1A1A) : const Color(0xFF9E9E9E),
      ),
    );
  }

  Widget _buildStepDot(bool isActive) {
    return Container(
      width: 14.w,
      height: 14.w,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? const Color(0xFF4A80F0) : const Color(0xFFE0E0E0),
          width: 2.w,
        ),
      ),
      child: isActive
          ? Center(
              child: Container(
                width: 6.w,
                height: 6.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF4A80F0),
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildClientInfo(bool isDarkMode) {
    return _buildCard(
      isDarkMode: isDarkMode,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundImage: const NetworkImage(
                  "https://i.pravatar.cc/150?u=mukaram",
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Mukaram Hussain",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF1A1A1A),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        SvgPicture.asset(
                          AppIcons.verifa,
                          width: 16.sp,
                          height: 16.sp,
                        ),
                      ],
                    ),
                    Text(
                      "Client",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildInfoRowWithDivider("Booking ID:", "BK-482913", isDarkMode),
          _buildInfoRowWithDivider("Accepted on:", "18 Jan 2026", isDarkMode),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Get.to(
                  () => ChatView(
                    userData: {
                      'image': "https://i.pravatar.cc/150?u=mukaram",
                      'name': "Mukaram Hussain",
                    },
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                side: const BorderSide(color: Color(0xFFE0E0E0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                "message".tr,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParcelInfo(bool isDarkMode) {
    return _buildCard(
      title: "Parcel Information",
      isDarkMode: isDarkMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRowWithDivider("Package Size", "Medium (15kg)", isDarkMode),
          _buildInfoRowWithDivider(
            "Delivery Time",
            "Jan 29, 2026 - Jan 31, 2026",
            isDarkMode,
          ),
          SizedBox(height: 16.h),
          Text(
            "Package Photos",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: const Color(0xFF9E9E9E),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildPackagePhoto("https://picsum.photos/200/200?random=1"),
              SizedBox(width: 12.w),
              _buildPackagePhoto("https://picsum.photos/200/200?random=2"),
            ],
          ),
          SizedBox(height: 20.h),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  color: const Color(0xFF9E9E9E),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFAEB),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  "Urgent",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFF79009),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPackagePhoto(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.network(url, width: 80.w, height: 80.w, fit: BoxFit.cover),
    );
  }

  Widget _buildRouteDetails(bool isDarkMode) {
    return _buildCard(
      title: "Route Details",
      isDarkMode: isDarkMode,
      child: Column(
        children: [
          _buildRouteItem(
            icon: AppIcons.departure,
            location: "Tunisia",
            date: "20 Jan",
            time: "08:30 AM",
            isDarkMode: isDarkMode,
          ),
          Padding(
            padding: EdgeInsets.only(left: 17.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                AppIcons.partion,
                height: 30.h,
                colorFilter: ColorFilter.mode(
                  const Color(0xFFE0E0E0),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          _buildRouteItem(
            icon: AppIcons.location,
            location: "France",
            date: "20 Jan",
            time: "10:45 PM",
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 20.h),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          SizedBox(height: 16.h),
          _buildInfoRow("Travel Mode:", "Flight", isDarkMode),
        ],
      ),
    );
  }

  Widget _buildRouteItem({
    required String icon,
    required String location,
    required String date,
    required String time,
    required bool isDarkMode,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: const BoxDecoration(
            color: Color(0xFFF5F7FA),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            icon,
            width: 18.w,
            height: 18.w,
            colorFilter: const ColorFilter.mode(
              Color(0xFF4A80F0),
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                ),
              ),
              Text(
                date,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.sp,
                  color: const Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.sp,
            color: isDarkMode ? Colors.white70 : const Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetails(bool isDarkMode) {
    return _buildCard(
      title: "Payment Details",
      isDarkMode: isDarkMode,
      child: Column(
        children: [
          _buildInfoRowWithDivider("Total Amount:", "140 TND", isDarkMode),
          _buildInfoRowWithDivider("Service Fee:", "10 TND", isDarkMode),
          SizedBox(height: 8.h),
          _buildInfoRow("Total Estimate", "150 TND", isDarkMode, isBold: true),
        ],
      ),
    );
  }

  Widget _buildCard({
    String? title,
    required Widget child,
    required bool isDarkMode,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 20.h),
          ],
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRowWithDivider(String label, String value, bool isDarkMode) {
    return Column(
      children: [
        _buildInfoRow(label, value, isDarkMode),
        const Divider(height: 24, color: Color(0xFFF0F0F0)),
      ],
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    bool isDarkMode, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            color: const Color(0xFF9E9E9E),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }
}
