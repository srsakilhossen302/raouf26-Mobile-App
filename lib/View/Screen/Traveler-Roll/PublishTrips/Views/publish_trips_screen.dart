import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Widgets/custom_reject_button.dart';
import '../../../../../Utils/AppIcons/app_icons.dart';
import '../../../../../Utils/AppImg/app_img.dart';
import '../../../../Widget/custom_bottom_nav_bar.dart';
import '../../../../Widget/custom_transporter_bottom_nav_bar.dart';
import '../Controllers/publish_trips_controller.dart';
import '../Models/trip_model.dart';
import '../Widgets/booking_details_modal.dart';
import '../../../../Widgets/booking_request_card.dart';
import 'publish_trip_flow_screen.dart';
import 'trip_details_screen.dart';

class PublishTripsScreen extends StatelessWidget {
  const PublishTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PublishTripsController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: Column(
        children: [
          // Custom Header with SafeArea
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Row(
                    children: [
                      // Leading / Spacer to maintain center alignment if needed
                      SizedBox(width: 48.w), 
                      
                      // Title
                      Expanded(
                        child: Obx(() {
                          String title = "Publish Trips";
                          if (controller.selectedTab.value == 1) title = "Trips";
                          if (controller.selectedTab.value == 2) title = "Requests";
                          return Text(
                            title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                            ),
                          );
                        }),
                      ),

                      // Actions
                      Obx(() {
                        if (controller.selectedTab.value == 0) {
                          return IconButton(
                            onPressed: () => showHowItWorks(context),
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
                        return SizedBox(width: 48.w); // Spacer for Requests tab
                      }),
                    ],
                  ),
                ),
                // Decorative Progress Indicator
                LinearProgressIndicator(
                  value: 0.15,
                  backgroundColor: isDarkMode ? Colors.white10 : Colors.grey.shade100,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4A80F0)),
                  minHeight: 2.h,
                ),
              ],
            ),
          ),
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
        () {
          if (controller.userRole.value == "Transporter" || controller.userRole.value == "") {
            return CustomTransporterBottomNavBar.buildFloatingActionButton(context);
          }
          return CustomBottomNavBar.buildFloatingActionButton();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () {
          if (controller.userRole.value == "Transporter" || controller.userRole.value == "") {
            return const CustomTransporterBottomNavBar(selectedIndex: 4);
          }
          return const CustomBottomNavBar(selectedIndex: 4);
        },
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

          // Highlight the number 3 in red for the Requests tab
          Widget labelWidget;
          if (label == "Requests (3)") {
            labelWidget = RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : (isDarkMode ? Colors.white70 : const Color(0xFF9E9E9E)),
                ),
                children: [
                  const TextSpan(text: "Requests ("),
                  TextSpan(
                    text: "3",
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.red,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ")"),
                ],
              ),
            );
          } else {
            labelWidget = Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : (isDarkMode ? Colors.white70 : const Color(0xFF9E9E9E)),
              ),
            );
          }

          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF4A80F0) : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(child: labelWidget),
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
            style: GoogleFonts.manrope(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Turn your journey into earning opportunities by carrying parcels along the way.",
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              color: isDarkMode ? Colors.white70 : const Color(0xFF666666),
              height: 1.5,
            ),
          ),
          SizedBox(height: 40.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => showHowItWorks(context),
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
                style: GoogleFonts.manrope(
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
    final controller = Get.find<PublishTripsController>();
    return Column(
      children: [
        _buildSubTabBar(isDarkMode),
        _buildFilterChips(controller, isDarkMode),
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

  Widget _buildFilterChips(PublishTripsController controller, bool isDarkMode) {
    return Obx(() {
      if (!controller.showFilterChips.value) return const SizedBox.shrink();

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              if (controller.selectedCity.value.isNotEmpty) ...[
                _buildChip(
                  controller.selectedCity.value,
                  isDarkMode,
                  onRemove: () => controller.removeCityFilter(),
                ),
                SizedBox(width: 12.w),
              ],
              if (controller.selectedDate.value.isNotEmpty) ...[
                _buildChip(
                  controller.selectedDate.value,
                  isDarkMode,
                  onRemove: () => controller.removeDateFilter(),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget _buildChip(String label, bool isDarkMode, {VoidCallback? onRemove}) {
    String? flag = _getFlagForLabel(label);
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
          if (flag != null) ...[
            if (flag.startsWith("http"))
              ClipRRect(
                borderRadius: BorderRadius.circular(2.r),
                child: Image.network(
                  flag,
                  width: 20.w,
                  height: 14.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.flag,
                    size: 14.sp,
                    color: Colors.grey,
                  ),
                ),
              )
            else
              Text(flag, style: TextStyle(fontSize: 14.sp)),
            SizedBox(width: 8.w),
          ],
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 14.sp,
              color: isDarkMode ? Colors.white60 : const Color(0xFF9E9E9E),
            ),
          ),
        ],
      ),
    );
  }

  String? _getFlagForLabel(String label) {
    if (label == "Tunis") return "https://flagcdn.com/w40/tn.png";
    if (label == "France") return "🇫🇷";
    if (label == "Germany") return "🇩🇪";
    if (label == "Italy") return "🇮🇹";
    if (label == "United Kingdom") return "🇬🇧";
    return null;
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
        style: GoogleFonts.manrope(
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
                style: GoogleFonts.manrope(
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
                  style: GoogleFonts.manrope(
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
            icon: AppIcons.trackingNavbar,
            city: "Tunisia",
            date: "03 March",
            time: "08:30 AM",
            isFirst: true,
            isDarkMode: isDarkMode,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Column(
              children: List.generate(
                3,
                (index) => Container(
                  width: 1.w,
                  height: 4.h,
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  color: isDarkMode ? Colors.white24 : const Color(0xFFE0E0E0),
                ),
              ),
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
                style: GoogleFonts.manrope(
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
            borderRadius: BorderRadius.circular(8.r),
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
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                ),
              ),
              Text(
                date,
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  color: isDarkMode ? Colors.white60 : const Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: GoogleFonts.manrope(
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
            spans.add(
              TextSpan(
                text: '(${numberPart[0]})',
                style: TextStyle(
                  color: Colors
                      .red, // Keep it red even when selected for contrast or white?
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
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
                style: GoogleFonts.manrope(
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
    final controller = Get.find<PublishTripsController>();
    return BookingRequestCard(
      userName: "Mukaram Hussain",
      userImage: "https://i.pravatar.cc/150?u=mukaram",
      timeAgo: "2 hrs ago",
      status: status,
      fromCity: "Tunisia",
      toCity: "France",
      fromDate: "20 Jan",
      toDate: "20 Jan",
      fromIcon: AppIcons.departure,
      fromTime: "08:30 AM",
      toTime: "10:45 PM",
      packageSize: "Medium (15kg)",
      packageStatus: "Urgent",
      totalPrice: "150 TND",
    );
  }

  void _showFilters(BuildContext context) {
    final controller = Get.find<PublishTripsController>();
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
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.resetFilters(),
                    child: Text(
                      "Clear all",
                      style: GoogleFonts.manrope(
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
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    GestureDetector(
                      onTap: () => _showCountrySelector(context, controller),
                      child: Obx(
                        () => Container(
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
                              if (controller.tempCity.value == "Tunis")
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(2.r),
                                  child: Image.network(
                                    "https://flagcdn.com/w40/tn.png",
                                    width: 24.w,
                                    height: 18.h,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                      Icons.flag,
                                      size: 16.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              else
                                Text(
                                  controller.tempCity.value == "France"
                                      ? "🇫🇷"
                                      : controller.tempCity.value == "Germany"
                                          ? "🇩🇪"
                                          : controller.tempCity.value == "Italy"
                                              ? "🇮🇹"
                                              : "🌍",
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  controller.tempCity.value.isEmpty
                                      ? "Select Country"
                                      : controller.tempCity.value,
                                  style: GoogleFonts.manrope(
                                    fontSize: 14.sp,
                                    color: isDarkMode
                                        ? Colors.white
                                        : const Color(0xFF1A1A1A),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: isDarkMode
                                    ? Colors.white60
                                    : Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "Select Date",
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    GestureDetector(
                      onTap: () => _selectDate(context, controller),
                      child: Obx(
                        () => Container(
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
                                  controller.tempDate.value.isEmpty
                                      ? "Select Date"
                                      : controller.tempDate.value,
                                  style: GoogleFonts.manrope(
                                    fontSize: 14.sp,
                                    color: controller.tempDate.value.isEmpty
                                        ? (isDarkMode
                                            ? Colors.white38
                                            : const Color(0xFF9E9E9E))
                                        : (isDarkMode
                                            ? Colors.white
                                            : const Color(0xFF1A1A1A)),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 20.sp,
                                color: isDarkMode
                                    ? Colors.white60
                                    : Colors.black54,
                              ),
                            ],
                          ),
                        ),
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
                      onPressed: () {
                        controller.resetFilters();
                        Get.back();
                      },
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
                        style: GoogleFonts.manrope(
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
                      onPressed: () {
                        controller.applyFilters();
                        Get.back();
                      },
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
                        style: GoogleFonts.manrope(
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

  void _showCountrySelector(
      BuildContext context, PublishTripsController controller) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final countries = [
      {"name": "Tunis", "flag": "🇹🇳", "code": "tn"},
      {"name": "France", "flag": "🇫🇷", "code": "fr"},
      {"name": "Germany", "flag": "🇩🇪", "code": "de"},
      {"name": "Italy", "flag": "🇮🇹", "code": "it"},
      {"name": "United Kingdom", "flag": "🇬🇧", "code": "gb"},
    ];

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Country",
              style: GoogleFonts.manrope(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20.h),
            ...countries
                .map((country) => ListTile(
                      onTap: () {
                        controller.tempCity.value = country["name"]!;
                        Get.back();
                      },
                      leading: Text(country["flag"]!,
                          style: TextStyle(fontSize: 24.sp)),
                      title: Text(
                        country["name"]!,
                        style: GoogleFonts.manrope(
                          fontWeight:
                              controller.tempCity.value == country["name"]
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      trailing: controller.tempCity.value == country["name"]
                          ? const Icon(Icons.check_circle,
                              color: Color(0xFF4A80F0))
                          : null,
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, PublishTripsController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4A80F0),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      String formattedDate =
          "${_getDayOfWeek(picked.weekday)} ${picked.day} ${_getMonth(picked.month)}, ${picked.year}";
      controller.tempDate.value = formattedDate;
    }
  }

  String _getDayOfWeek(int day) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[day - 1];
  }

  String _getMonth(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  static void showHowItWorks(BuildContext context) {
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "How It Works",
                  style: GoogleFonts.manrope(
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
              style: GoogleFonts.manrope(
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
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 16.h),
            buildLearnItem("How to publish your trip", isDarkMode),
            buildLearnItem("How to set prices and capacity", isDarkMode),
            buildLearnItem("How to accept delivery requests", isDarkMode),
            buildLearnItem("How you get paid", isDarkMode),
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
                  style: GoogleFonts.manrope(
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
    ),
  );
}

  static Widget buildLearnItem(String text, bool isDarkMode) {
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
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              color: isDarkMode ? Colors.white70 : const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

}

