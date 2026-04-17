import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Utils/AppIcons/app_icons.dart';
import '../../../../../Utils/AppImg/app_img.dart';
import '../../../../Widget/custom_bottom_nav_bar.dart';
import '../../../../Widget/custom_transporter_bottom_nav_bar.dart';
import '../Controllers/publish_trips_controller.dart';
import '../Models/trip_model.dart';
import '../Widgets/booking_details_modal.dart';
import 'publish_trip_flow_screen.dart';
import 'trip_details_screen.dart';

class PublishTripsScreen extends StatelessWidget {
  const PublishTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PublishTripsController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Obx(() {
          String title = "Publish Trips";
          if (controller.selectedTab.value == 1) title = "Trips";
          if (controller.selectedTab.value == 2) title = "Requests";
          return Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
            ),
          );
        }),
        actions: [
          Obx(() {
            if (controller.selectedTab.value == 0) {
              return IconButton(
                onPressed: () => _showHowItWorks(context),
                icon: Icon(
                  Icons.info_outline,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                  size: 24.sp,
                ),
              );
            } else if (controller.selectedTab.value == 1) {
              return IconButton(
                onPressed: () => _showFilters(context),
                icon: SvgPicture.asset(
                  AppIcons.filters,
                  width: 24.w,
                  height: 24.w,
                  colorFilter: ColorFilter.mode(
                    isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                    BlendMode.srcIn,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          SizedBox(width: 8.w),
        ],
      ),
      body: Column(
        children: [
          _buildTabBar(controller, isDarkMode),
          Expanded(
            child: Obx(() {
              switch (controller.selectedTab.value) {
                case 0:
                  return _buildPublishTab(context, isDarkMode);
                case 1:
                  return _buildMyTripsTab(context, isDarkMode);
                case 2:
                  return _buildRequestsTab(context, isDarkMode);
                default:
                  return const SizedBox();
              }
            }),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () => controller.userRole.value == "Transporter"
            ? CustomTransporterBottomNavBar.buildFloatingActionButton()
            : CustomBottomNavBar.buildFloatingActionButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => controller.userRole.value == "Transporter"
            ? const CustomTransporterBottomNavBar(selectedIndex: 4)
            : const CustomBottomNavBar(selectedIndex: 4),
      ),
    );
  }

  Widget _buildTabBar(PublishTripsController controller, bool isDarkMode) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _buildTabItem("Publish", 0, controller, isDarkMode),
          _buildTabItem("My Trips", 1, controller, isDarkMode),
          _buildTabItem("Requests (3)", 2, controller, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    String label,
    int index,
    PublishTripsController controller,
    bool isDarkMode,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Obx(() {
          bool isSelected = controller.selectedTab.value == index;

          // Split label to highlight numbers in red
          List<TextSpan> spans = [];
          if (label.contains('(') && label.contains(')')) {
            final parts = label.split('(');
            spans.add(TextSpan(text: parts[0]));
            final numberPart = parts[1].split(')');
            spans.add(TextSpan(
              text: '(${numberPart[0]})',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ));
            if (numberPart.length > 1) {
              spans.add(TextSpan(text: numberPart[1]));
            }
          } else {
            spans.add(TextSpan(text: label));
          }

          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF4A80F0) : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text.rich(
                TextSpan(children: spans),
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : (isDarkMode ? Colors.white70 : const Color(0xFF9E9E9E)),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPublishTab(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image.asset(AppImg.publishTrip, width: 250.w, height: 250.w),
          SizedBox(height: 24.h),
          Text(
            "Publish a New Trip",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Turn your journey into earning opportunities by carrying parcels along the way.",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: isDarkMode ? Colors.white70 : const Color(0xFF666666),
              height: 1.5,
            ),
          ),
          SizedBox(height: 40.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showHowItWorks(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A80F0),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "Publish Trip",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyTripsTab(BuildContext context, bool isDarkMode) {
    return Column(
      children: [
        _buildSubTabBar(isDarkMode),
        _buildFilterChips(isDarkMode),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            itemCount: 2,
            itemBuilder: (context, index) {
              return _buildTripCard(context, isDarkMode);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips(bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          _buildChip("Tunis", isDarkMode),
          SizedBox(width: 12.w),
          _buildChip("Tue 3 March, 2026", isDarkMode),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isDarkMode ? Colors.white24 : const Color(0xFFE0E0E0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label == "Tunis") ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(2.r),
              child: Image.network(
                "https://flagcdn.com/w40/tn.png",
                width: 20.w,
                height: 14.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.w),
          ],
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.close,
            size: 14.sp,
            color: isDarkMode ? Colors.white60 : const Color(0xFF9E9E9E),
          ),
        ],
      ),
    );
  }

  Widget _buildSubTabBar(bool isDarkMode) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Row(
        children: [
          _buildSubTabItem("All", true, isDarkMode),
          SizedBox(width: 10.w),
          _buildSubTabItem("Publish", false, isDarkMode),
          SizedBox(width: 10.w),
          _buildSubTabItem("Drafts", false, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildSubTabItem(String label, bool isSelected, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected
            ? (isDarkMode ? Colors.white : Colors.black)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isSelected
              ? (isDarkMode ? Colors.white : Colors.black)
              : (isDarkMode ? Colors.white24 : const Color(0xFFE0E0E0)),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14.sp,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected
              ? (isDarkMode ? Colors.black : Colors.white)
              : (isDarkMode ? Colors.white70 : const Color(0xFF9E9E9E)),
        ),
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Route",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F6EC),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  "Active",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF039855),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildRoutePoint(
            icon: AppIcons.departure,
            city: "Tunisia",
            date: "03 March",
            time: "08:30 AM",
            isFirst: true,
            isDarkMode: isDarkMode,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Container(
              width: 1.w,
              height: 30.h,
              color: isDarkMode ? Colors.white24 : const Color(0xFFE0E0E0),
            ),
          ),
          _buildRoutePoint(
            icon: AppIcons.location,
            city: "France",
            date: "03 March",
            time: "10:45 PM",
            isFirst: false,
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                final dummyTrip = TripModel(
                  id: "1",
                  departureCity: "Tunisia",
                  arrivalCity: "France",
                  departureDate: "03 March",
                  arrivalDate: "03 March",
                  departureTime: "08:30 AM",
                  arrivalTime: "10:45 PM",
                  stops: "40, Sidi Bu Jafar, Sousse, Tunisia",
                  maxWeight: "Medium (15kg)",
                  pricePerKg: "2.5 TND",
                  travelMode: "Flight",
                );
                Get.to(() => TripDetailsScreen(trip: dummyTrip));
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                side: BorderSide(
                  color: isDarkMode ? Colors.white24 : const Color(0xFFE0E0E0),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                "View Details",
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

  Widget _buildRequestsTab(BuildContext context, bool isDarkMode) {
    final controller = Get.find<PublishTripsController>();
    return Column(
      children: [
        _buildRequestSubTabBar(controller, isDarkMode),
        Expanded(
          child: Obx(() {
            // Trigger dependency tracking by accessing value here
            final currentSubTab = controller.requestSubTab.value;
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              itemCount: 2,
              itemBuilder: (context, index) {
                String status = "Pending";
                if (currentSubTab == 1) status = "Accepted";
                if (currentSubTab == 2) status = "Declined";
                return _buildRequestCard(context, isDarkMode, status);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildRequestSubTabBar(
    PublishTripsController controller,
    bool isDarkMode,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Row(
        children: [
          _buildRequestSubTabItem("Pending", 0, controller, isDarkMode),
          SizedBox(width: 10.w),
          _buildRequestSubTabItem("Accepted", 1, controller, isDarkMode),
          SizedBox(width: 10.w),
          _buildRequestSubTabItem("Declined", 2, controller, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildRequestSubTabItem(
    String label,
    int index,
    PublishTripsController controller,
    bool isDarkMode,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeRequestSubTab(index),
        child: Obx(() {
          bool isSelected = controller.requestSubTab.value == index;

          // Split label to highlight numbers in red
          List<TextSpan> spans = [];
          if (label.contains('(') && label.contains(')')) {
            final parts = label.split('(');
            spans.add(TextSpan(text: parts[0]));
            final numberPart = parts[1].split(')');
            spans.add(TextSpan(
              text: '(${numberPart[0]})',
              style: TextStyle(
                color: Colors.red, // Keep it red even when selected for contrast or white?
                fontWeight: FontWeight.bold,
              ),
            ));
            if (numberPart.length > 1) {
              spans.add(TextSpan(text: numberPart[1]));
            }
          } else {
            spans.add(TextSpan(text: label));
          }

          return Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDarkMode ? Colors.white : Colors.black)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isSelected
                    ? (isDarkMode ? Colors.white : Colors.black)
                    : (isDarkMode ? Colors.white24 : const Color(0xFFE0E0E0)),
              ),
            ),
            child: Center(
              child: Text.rich(
                TextSpan(children: spans),
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? (isDarkMode ? Colors.black : Colors.white)
                      : (isDarkMode ? Colors.white70 : const Color(0xFF9E9E9E)),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRequestCard(
    BuildContext context,
    bool isDarkMode,
    String status,
  ) {
    Color statusColor;
    Color statusBgColor;

    switch (status) {
      case "Accepted":
        statusColor = const Color(0xFF039855);
        statusBgColor = const Color(0xFFE7F6EC);
        break;
      case "Declined":
        statusColor = const Color(0xFFD92D20);
        statusBgColor = const Color(0xFFFEE4E2);
        break;
      default:
        statusColor = const Color(0xFFF79009);
        statusBgColor = const Color(0xFFFFFAEB);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: const NetworkImage(
                  "https://i.pravatar.cc/150?u=mukaram",
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mukaram Hussain",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode
                            ? Colors.white
                            : const Color(0xFF1A1A1A),
                      ),
                    ),
                    Text(
                      "2 hrs ago",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        color: isDarkMode
                            ? Colors.white60
                            : const Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildRoutePoint(
            icon: AppIcons.departure,
            city: "Tunisia",
            date: "20 Jan",
            time: "08:30 AM",
            isFirst: true,
            isDarkMode: isDarkMode,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Container(
              width: 1.w,
              height: 30.h,
              color: isDarkMode ? Colors.white24 : const Color(0xFFE0E0E0),
            ),
          ),
          _buildRoutePoint(
            icon: AppIcons.location,
            city: "France",
            date: "20 Jan",
            time: "10:45 PM",
            isFirst: false,
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 10.h),
          _buildRequestDetailRow("Package Size", "Medium (15kg)", isDarkMode),
          _buildRequestDetailRow(
            "Status",
            "Urgent",
            isDarkMode,
            isUrgent: true,
          ),
          _buildRequestDetailRow(
            "Total Estimate",
            "150 TND",
            isDarkMode,
            isBold: true,
          ),
          SizedBox(height: 20.h),
          if (status == "Accepted")
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  side: BorderSide(
                    color: isDarkMode
                        ? Colors.white24
                        : const Color(0xFFE0E0E0),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "View Details",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                  ),
                ),
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      side: const BorderSide(color: Color(0xFFFFEAEA)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Reject",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFF3B3B),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showBookingDetails(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A80F0),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Accept",
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
    );
  }

  Widget _buildRequestDetailRow(
    String label,
    String value,
    bool isDarkMode, {
    bool isUrgent = false,
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: isDarkMode ? Colors.white38 : const Color(0xFF9E9E9E),
            ),
          ),
          if (isUrgent)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFAEB),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFF79009),
                ),
              ),
            )
          else
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
                color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
              ),
            ),
        ],
      ),
    );
  }

  void _showBookingDetails(BuildContext context) {
    Get.to(() => const BookingDetailsScreen());
  }

  void _showFilters(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    "Filters",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode
                          ? Colors.white
                          : const Color(0xFF1A1A1A),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Clear all",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        color: const Color(0xFF4A80F0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Country",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode
                            ? Colors.white
                            : const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color(0xFF2C2C2C)
                            : const Color(0xFFF5F7FA),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2.r),
                            child: Image.network(
                              "https://flagcdn.com/w40/tn.png",
                              width: 24.w,
                              height: 18.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "Tunis",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color(0xFF1A1A1A),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: isDarkMode ? Colors.white60 : Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "Select Date",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode
                            ? Colors.white
                            : const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color(0xFF2C2C2C)
                            : const Color(0xFFF5F7FA),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Select Date",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? Colors.white38
                                    : const Color(0xFF9E9E9E),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 20.sp,
                            color: isDarkMode ? Colors.white60 : Colors.black54,
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
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: BorderSide(
                          color: isDarkMode
                              ? Colors.white24
                              : const Color(0xFFE0E0E0),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        "Reset",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode
                              ? Colors.white
                              : const Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
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
                        "Apply",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHowItWorks(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "How It Works",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            Text(
              "Watch this short video to understand how publishing a trip and delivering parcels works.",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                color: isDarkMode ? Colors.white70 : const Color(0xFF666666),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black26 : const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 64.w,
                  color: const Color(0xFF4A80F0),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "What you’ll learn:",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 16.h),
            _buildLearnItem("How to publish your trip", isDarkMode),
            _buildLearnItem("How to set prices and capacity", isDarkMode),
            _buildLearnItem("How to accept delivery requests", isDarkMode),
            _buildLearnItem("How you get paid", isDarkMode),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.to(() => const PublishTripFlowScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Got It",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearnItem(String text, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 4.w,
            height: 4.w,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white70 : const Color(0xFF666666),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: isDarkMode ? Colors.white70 : const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}
