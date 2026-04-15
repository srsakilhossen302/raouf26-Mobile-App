import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../Utils/AppIcons/app_icons.dart';
import '../../controller/transporter_tracking_controller.dart';
import '../transporter_trip_details_view.dart';
import 'pickup_confirmation_sheet.dart';
import 'delivery_confirmation_sheet.dart';

class TrackingListWidget extends StatelessWidget {
  final TransporterTrackingController controller;
  final bool isDarkMode;

  const TrackingListWidget({
    super.key,
    required this.controller,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white10 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: 'search_package'.tr,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.sp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              ),
            ),
          ),
        ),

        // Filter Tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: List.generate(
              controller.filterTabs.length,
              (index) => Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Obx(() => _buildFilterTab(index)),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),

        // Tracking Cards
        Expanded(
          child: Obx(
            () => ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: controller.packages.length,
              itemBuilder: (context, index) {
                return _buildTrackingCard(controller.packages[index], context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTab(int index) {
    bool isSelected = controller.selectedFilterTab.value == index;
    return GestureDetector(
      onTap: () => controller.setFilterTab(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode ? Colors.white24 : Colors.black)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (isDarkMode ? Colors.white24 : Colors.grey.shade300),
          ),
        ),
        child: Text(
          controller.filterTabs[index].tr,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? (isDarkMode ? Colors.white : Colors.white)
                : (isDarkMode ? Colors.white70 : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildTrackingCard(
    TrackingPackageModel package,
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        children: [
          // Header: Profile & Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage: NetworkImage(package.userImage),
                    onBackgroundImageError: (_, __) {},
                    child: Icon(Icons.person, color: Colors.white, size: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.userName,
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        package.id,
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "€${package.price.toStringAsFixed(0)}",
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Status Timeline
          _buildStatusTimeline(package.currentStatusStep),
          SizedBox(height: 24.h),

          // Route Timeline
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    AppIcons.departure,
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                    width: 16.w,
                  ),
                  Container(
                    height: 24.h,
                    width: 1,
                    color: Colors.grey.shade300,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                  ),
                  SvgPicture.asset(
                    AppIcons.location,
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                    width: 16.w,
                  ),
                ],
              ),
              SizedBox(width: 16.w),
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
                              "Pickup",
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              "${package.fromCity} \u2022 ${package.toCity}",
                              style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          package.fromTime,
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Drop-off",
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              "${package.toCity} \u2022 ${package.fromCity}",
                              style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          package.toTime,
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.to(() => TransporterTripDetailsView(package: package));
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: BorderSide(
                      color: isDarkMode ? Colors.white24 : Colors.grey.shade300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'view_details'.tr,
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showPickupConfirmationSheet(context, package);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    backgroundColor: const Color(0xFF4A80F0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'mark_as_delivered'.tr,
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
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

  Widget _buildStatusTimeline(int currentStep) {
    const steps = ["Booked", "Picked Up", "In Transit", "Delivered"];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(steps.length, (index) {
            return Text(
              steps[index].tr,
              style: GoogleFonts.montserrat(
                fontSize: 10.sp,
                fontWeight: index <= currentStep
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: index <= currentStep
                    ? (isDarkMode ? Colors.white : Colors.black)
                    : Colors.grey,
              ),
            );
          }),
        ),
        SizedBox(height: 8.h),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 2.h,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(steps.length, (index) {
                // Line coverage
                bool isActive = index <= currentStep;
                return Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : Colors.grey.shade300,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive
                          ? const Color(0xFF4A80F0)
                          : Colors.transparent,
                      width: 3.w,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}
