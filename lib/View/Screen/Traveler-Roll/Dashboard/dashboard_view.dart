import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/AppImg/app_img.dart';
import '../../../Widget/custom_bottom_nav_bar.dart';
import 'dashboard_controller.dart';
import '../Search/map_picker_screen.dart';
import '../PackageDetails/package_details_view.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FE),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Blue Section with Background Image
            Stack(
              children: [
                Container(
                  height: 220.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: const Color(0xFF4A80F0),
                    image: DecorationImage(
                      image: AssetImage(AppImg.dashboardBg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        // Dashboard Card
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(24.r),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? const Color(0xFF1E1E1E)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(24.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "dashboard_title".tr,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "dashboard_subtitle".tr,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: isDarkMode
                                      ? Colors.white60
                                      : Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(height: 24.h),
                              Text(
                                "quick_actions".tr,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                children: [
                                  _quickActionCard(
                                    title: "send_package".tr,
                                    subtitle: "ship_with_traveler".tr,
                                    icon: AppIcons.sendPackage,
                                    isDarkMode: isDarkMode,
                                  ),
                                  SizedBox(width: 16.w),
                                  _quickActionCard(
                                    title: "carry_package".tr,
                                    subtitle: "earn_on_trip".tr,
                                    icon: AppIcons.carryPackage,
                                    isDarkMode: isDarkMode,
                                  ),
                                ],
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

            // Statistics Section
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                children: [
                  _sectionHeader("statistics".tr, isDarkMode),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(0xFF1E1E1E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      children: [
                        _statsRow(
                          icon: AppIcons.totalEarnings,
                          label: "total_earnings".tr,
                          value: controller.totalEarnings.value,
                          isDarkMode: isDarkMode,
                        ),
                        Divider(
                          height: 32.h,
                          color: isDarkMode
                              ? Colors.white10
                              : Colors.grey.shade100,
                        ),
                        _statsRow(
                          icon: AppIcons.clients,
                          label: "clients".tr,
                          value: controller.clientsCount.value,
                          isDarkMode: isDarkMode,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _sectionHeader("total_earnings".tr, isDarkMode),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(0xFF1E1E1E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 180.h,
                          child: Row(
                            children: [
                              // Y-Axis Labels
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _chartYLabel("€500"),
                                  _chartYLabel("€200"),
                                  _chartYLabel("€100"),
                                  _chartYLabel("€50"),
                                  _chartYLabel("0"),
                                ],
                              ),
                              SizedBox(width: 10.w),
                              // Chart Area with Grid Lines
                              Expanded(
                                child: Stack(
                                  children: [
                                    // Grid Lines
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                        5,
                                        (index) => Divider(
                                          height: 1,
                                          thickness: 0.5,
                                          color: isDarkMode
                                              ? Colors.white10
                                              : Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                    // Vertical Grid Lines (Optional, but matches image style)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: List.generate(
                                        7,
                                        (index) => VerticalDivider(
                                          width: 1,
                                          thickness: 0.5,
                                          color: isDarkMode
                                              ? Colors.white10
                                              : Colors.grey.shade100,
                                        ),
                                      ),
                                    ),
                                    // Bars
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          _chartBar(70.h),
                                          _chartBar(130.h),
                                          _chartBar(110.h),
                                          _chartBar(170.h),
                                          _chartBar(130.h),
                                          _chartBar(50.h),
                                          _chartBar(110.h),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        // X-Axis Labels
                        Padding(
                          padding: EdgeInsets.only(left: 45.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _chartXLabel("Mon"),
                              _chartXLabel("Tue"),
                              _chartXLabel("Wed"),
                              _chartXLabel("Thu"),
                              _chartXLabel("Fri"),
                              _chartXLabel("Sat"),
                              _chartXLabel("Sun"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _sectionHeaderWithAction(
                    "Today's Trip",
                    "See all",
                    isDarkMode,
                  ),
                  SizedBox(height: 16.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _todayTripCard(isDarkMode),
                        SizedBox(width: 16.w),
                        _todayTripCard(isDarkMode),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _sectionHeaderWithAction("Upcoming Trips", "", isDarkMode),
                  SizedBox(height: 16.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _upcomingTripItem("Tunis", "Paris", isDarkMode),
                        SizedBox(width: 16.w),
                        _upcomingTripItem("Alger", "Marseille", isDarkMode),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _sectionHeaderWithAction("Recent Activity", "", isDarkMode),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(0xFF1E1E1E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      children: [
                        _recentActivityItem(
                          "Trip Completed",
                          "Tunis -> Paris",
                          "2h ago",
                          isDarkMode,
                        ),
                        Divider(
                          height: 32.h,
                          color: isDarkMode
                              ? Colors.white10
                              : Colors.grey.shade100,
                        ),
                        _recentActivityItem(
                          "New Message",
                          "From Client",
                          "5h ago",
                          isDarkMode,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeaderWithAction(
    String title,
    String action,
    bool isDarkMode,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        if (action.isNotEmpty)
          Text(
            action,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
      ],
    );
  }

  Widget _todayTripCard(bool isDarkMode) {
    return Container(
      width: 280.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isDarkMode
            ? []
            : [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tunis \u2192 Paris",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                "€25",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            "14 Jan \u2022 2:30 PM",
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 16.h),
          Divider(
            height: 1,
            color: isDarkMode ? Colors.white10 : Colors.grey.shade100,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              CircleAvatar(
                radius: 15.r,
                backgroundImage: const NetworkImage(
                  "https://i.pravatar.cc/150?img=11",
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                "Ahmed B.",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(width: 4.w),
              SvgPicture.asset(AppIcons.verifa, width: 14.w, height: 14.h),
              const Spacer(),
              Text(
                "5h ago",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _upcomingTripItem(String from, String to, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : Colors.grey.shade50,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppIcons.upcoming,
              height: 16.r,
              colorFilter: ColorFilter.mode(
                isDarkMode ? Colors.white70 : Colors.grey.shade700,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            "$from \u2192 $to",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _recentActivityItem(
    String title,
    String subtitle,
    String time,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.white.withOpacity(0.05)
                : Colors.grey.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
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
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _quickActionCard({
    required String title,
    required String subtitle,
    required String icon,
    required bool isDarkMode,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.white.withOpacity(0.03)
              : const Color(0xFFF8F9FE),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isDarkMode ? Colors.white12 : Colors.grey.shade100,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: const Color(0xFF4A80F0).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon,
                height: 20.r,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF4A80F0),
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10.sp,
                color: isDarkMode ? Colors.white54 : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white10 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Text(
                "Weekly",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, size: 16.sp, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statsRow({
    required String icon,
    required String label,
    required String value,
    required bool isDarkMode,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.white.withOpacity(0.05)
                : Colors.grey.shade50,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              isDarkMode ? Colors.white70 : Colors.black54,
              BlendMode.srcIn,
            ),
            height: 20.sp,
            width: 20.sp,
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _chartYLabel(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
    );
  }

  Widget _chartXLabel(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
    );
  }

  Widget _chartBar(double height) {
    return Container(
      width: 15.w,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF4A80F0),
        borderRadius: BorderRadius.circular(4.r),
      ),

    );
  }
}
