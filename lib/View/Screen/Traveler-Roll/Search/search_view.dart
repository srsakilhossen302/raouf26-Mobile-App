import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../Widget/custom_bottom_nav_bar.dart';
import '../../../../Utils/AppImg/app_img.dart';
import 'search_controller.dart';
import 'map_picker_screen.dart';

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
                        // Status Bar Area
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "9:42",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.signal_cellular_alt,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.wifi,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.battery_full,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        // User Profile Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24.r,
                                  backgroundImage: const NetworkImage(
                                    "https://i.pravatar.cc/150?u=a042581f4e29026704d",
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      "Ready to Send a Parcel?",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                          "Enter Your Route",
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // Route Inputs
                        Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.03)
                                : const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.white10
                                  : Colors.grey.shade100,
                            ),
                          ),
                          child: Column(
                            children: [
                              Obx(
                                () => _routeInputField(
                                  iconPath: "assets/icons/delveri-Icons.svg",
                                  label: "Pick Up",
                                  address: controller.pickUpAddress.value,
                                  isDarkMode: isDarkMode,
                                  onMapTap: () async {
                                    var result = await Get.to(
                                      () => const MapPickerScreen(
                                        title: "Pickup Point",
                                      ),
                                    );
                                    if (result != null) {
                                      controller.updatePickUp(result);
                                    }
                                  },
                                  onClearTap: () => controller.clearPickUp(),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.w),
                                child: Row(
                                  children: [
                                    Column(
                                      children: List.generate(
                                        3,
                                        (index) => Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 2.h,
                                          ),
                                          width: 1.w,
                                          height: 4.h,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: isDarkMode
                                            ? Colors.white10
                                            : Colors.grey.shade100,
                                        indent: 20.w,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Obx(
                                () => _routeInputField(
                                  iconPath: "assets/icons/Location-icons.svg",
                                  label: "Drop",
                                  address: controller.dropAddress.value,
                                  isDarkMode: isDarkMode,
                                  onMapTap: () async {
                                    var result = await Get.to(
                                      () => const MapPickerScreen(
                                        title: "Drop Point",
                                      ),
                                    );
                                    if (result != null) {
                                      controller.updateDrop(result);
                                    }
                                  },
                                  onClearTap: () => controller.clearDrop(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // Date Selection
                        Text(
                          "Select Date",
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.03)
                                : const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.white10
                                  : Colors.grey.shade100,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Select Date",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.black54,
                                size: 20.sp,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        // Continue Button
                        SizedBox(
                          width: double.infinity,
                          height: 52.h,
                          child: ElevatedButton(
                            onPressed: () {},
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
                  SizedBox(height: 12.h),
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

  Widget _routeInputField({
    required String iconPath,
    required String label,
    required String address,
    required bool isDarkMode,
    required VoidCallback onMapTap,
    required VoidCallback onClearTap,
  }) {
    bool hasAddress = address != "Where should it be delivered?";

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: SvgPicture.asset(
            iconPath,
            width: 16.sp,
            height: 16.sp,
            colorFilter: const ColorFilter.mode(
              Color(0xFF424242),
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: GestureDetector(
            onTap: onMapTap,
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.montserrat(
                    fontSize: 10.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  address,
                  style: GoogleFonts.montserrat(
                    fontSize: 13.sp,
                    color: hasAddress
                        ? (isDarkMode ? Colors.white : Colors.black87)
                        : Colors.grey.shade400,
                    fontWeight: hasAddress ? FontWeight.w600 : FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: onMapTap,
              child: Icon(
                Icons.map_outlined,
                color: Colors.black54,
                size: 20.sp,
              ),
            ),
            if (hasAddress) ...[
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: onClearTap,
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey.shade400,
                  size: 20.sp,
                ),
              ),
            ],
          ],
        ),
      ],
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
