import 'package:flutter/material.dart';

import '../Profile/profile_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../Widget/custom_bottom_nav_bar.dart';
import '../../../../Utils/AppImg/app_img.dart';
import 'search_controller.dart';
import 'map_picker_screen.dart';
import '../PackageDetails/package_details_view.dart';

class SearchScreen extends GetView<TravelerSearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TravelerSearchController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FE),
      floatingActionButton: CustomBottomNavBar.buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Blue Header
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
                        // User Profile Header
                        GestureDetector(
                          onTap: () => Get.to(() => const ProfilePage()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24.r,
                                      backgroundImage: const NetworkImage(
                                        "https://i.pravatar.cc/150?u=a042581f4e29026704d",
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hi, Zain Malik",
                                            style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "Where would you like to send your package?",
                                            style: GoogleFonts.montserrat(
                                              color: Colors.white.withOpacity(0.8),
                                              fontSize: 12.sp,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.qr_code_scanner,
                                      color: Colors.white,
                                      size: 24.sp,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Container(
                                    padding: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.notifications_none,
                                      color: Colors.white,
                                      size: 24.sp,
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
                ),

                // Route Input Card
                Padding(
                  padding: EdgeInsets.only(top: 140.h, left: 20.w, right: 20.w),
                  child: Container(
                    padding: EdgeInsets.all(20.r),
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
                          "Set Your Route",
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // Route Inputs
                        Container(
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.03)
                                : const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: () async {
                                    var result = await Get.to(
                                      () => const MapPickerScreen(
                                        title: "Pickup Point",
                                      ),
                                    );
                                    if (result != null) {
                                      controller.updatePickUp(result);
                                    }
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10.r),
                                        decoration: BoxDecoration(
                                          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.05),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: SvgPicture.asset(
                                          AppIcons.delivery,
                                          colorFilter: ColorFilter.mode(
                                            isDarkMode ? Colors.white : Colors.black87,
                                            BlendMode.srcIn,
                                          ),
                                          width: 20.sp,
                                          height: 20.sp,
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Pick Up",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12.sp,
                                                color: isDarkMode ? Colors.white54 : Colors.grey.shade300,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              controller.pickUpAddress.value == "Where should it be picked up?" || controller.pickUpAddress.value.isEmpty 
                                                  ? "Where should it be picked up?" 
                                                  : controller.pickUpAddress.value,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14.sp,
                                                color: controller.pickUpAddress.value == "Where should it be picked up?" || controller.pickUpAddress.value.isEmpty
                                                    ? Colors.grey.shade400
                                                    : (isDarkMode ? Colors.white : Colors.black87),
                                                fontWeight: controller.pickUpAddress.value == "Where should it be picked up?" || controller.pickUpAddress.value.isEmpty ? FontWeight.w500 : FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 19.w, top: 4.h, bottom: 4.h),
                                child: Column(
                                  children: List.generate(
                                    3,
                                    (index) => Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 3.h,
                                      ),
                                      width: 1.w,
                                      height: 5.h,
                                      color: isDarkMode ? Colors.white24 : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => GestureDetector(
                                  onTap: () async {
                                    var result = await Get.to(
                                      () => const MapPickerScreen(
                                        title: "Drop Point",
                                      ),
                                    );
                                    if (result != null) {
                                      controller.updateDrop(result);
                                    }
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10.r),
                                        decoration: BoxDecoration(
                                          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.05),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: SvgPicture.asset(
                                          AppIcons.location,
                                          colorFilter: ColorFilter.mode(
                                            isDarkMode ? Colors.white : Colors.black87,
                                            BlendMode.srcIn,
                                          ),
                                          width: 20.sp,
                                          height: 20.sp,
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Drop",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12.sp,
                                                color: isDarkMode ? Colors.white54 : Colors.grey.shade300,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              controller.dropAddress.value == "Where should it be delivered?" || controller.dropAddress.value.isEmpty
                                                  ? "Where should it be delivered?"
                                                  : controller.dropAddress.value,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14.sp,
                                                color: controller.dropAddress.value == "Where should it be delivered?" || controller.dropAddress.value.isEmpty
                                                    ? Colors.grey.shade400
                                                    : (isDarkMode ? Colors.white : Colors.black87),
                                                fontWeight: controller.dropAddress.value == "Where should it be delivered?" || controller.dropAddress.value.isEmpty ? FontWeight.w500 : FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                        SizedBox(height: 20.h),
                        // Date Selection
                        Text(
                          "Pickup Date",
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        GestureDetector(
                          onTap: () => _showDatePicker(context, isDarkMode),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.03)
                                  : const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Text(
                                    controller.selectedDateStr.value,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      color:
                                          controller.selectedDateStr.value ==
                                              "Choose pickup date"
                                          ? Colors.grey.shade400
                                          : (isDarkMode
                                                ? Colors.white
                                                : Colors.black87),
                                      fontWeight:
                                          controller.selectedDateStr.value ==
                                              "Choose pickup date"
                                          ? FontWeight.w500
                                          : FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                  AppIcons.date,
                                  colorFilter: ColorFilter.mode(
                                    isDarkMode ? Colors.white54 : Colors.black87,
                                    BlendMode.srcIn,
                                  ),
                                  width: 20.sp,
                                  height: 20.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        // Continue Button
                        SizedBox(
                          width: double.infinity,
                          height: 52.h,
                          child: ElevatedButton(
                            onPressed: () =>
                                Get.to(() => const PackageDetailsScreen()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4A80F0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              "Continue",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Recent Rides Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Rides",
                        style: GoogleFonts.montserrat(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "See all",
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _recentRideItem(
                    "Tunis",
                    "Paris",
                    "14 Jan",
                    "2:30 PM",
                    isDarkMode,
                  ),
                  SizedBox(height: 12.h),
                  _recentRideItem(
                    "Tunis",
                    "Maseille",
                    "14 Jan",
                    "2:30 PM",
                    isDarkMode,
                  ),
                  SizedBox(height: 12.h),
                  _recentRideItem(
                    "Tunis",
                    "Rome",
                    "14 Jan",
                    "2:30 PM",
                    isDarkMode,
                  ),
                  SizedBox(height: 12.h),
                  _recentRideItem(
                    "Tunis",
                    "London",
                    "14 Jan",
                    "2:30 PM",
                    isDarkMode,
                  ),
                  _recentRideItem(
                    "Tunis",
                    "Italy",
                    "14 Jan",
                    "2:30 PM",
                    isDarkMode,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context, bool isDarkMode) {
    DateTime focusedDay = controller.selectedDate.value ?? DateTime.now();
    DateTime? tempSelectedDay = controller.selectedDate.value;

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 24),
                    Text(
                      "Select a Date",
                      style: GoogleFonts.montserrat(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.close,
                        color: isDarkMode ? Colors.white : Colors.black,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (day) =>
                      isSameDay(tempSelectedDay, day),
                  onDaySelected: (selectedDay, focusedDayUpdate) {
                    setState(() {
                      tempSelectedDay = selectedDay;
                      focusedDay = focusedDayUpdate;
                    });
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: const Color(0xFF4A80F0).withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFF4A80F0),
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: GoogleFonts.montserrat(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    weekendTextStyle: GoogleFonts.montserrat(
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                    outsideTextStyle: GoogleFonts.montserrat(
                      color: isDarkMode ? Colors.white24 : Colors.grey.shade400,
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: GoogleFonts.montserrat(
                      color: Colors.grey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    weekendStyle: GoogleFonts.montserrat(
                      color: isDarkMode
                          ? Colors.redAccent.withOpacity(0.7)
                          : Colors.redAccent,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateDate(tempSelectedDay ?? focusedDay);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A80F0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Confirm",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          );
        },
      ),
      isScrollControlled: true,
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
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.arrow_forward,
                      size: 14.sp,
                      color: Colors.black87,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      to,
                      style: GoogleFonts.montserrat(
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
                  style: GoogleFonts.montserrat(
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
