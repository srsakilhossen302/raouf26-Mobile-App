import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../Utils/AppIcons/app_icons.dart';
import '../../controller/transporter_tracking_controller.dart';
import '../transporter_trip_details_view.dart';
import 'pickup_confirmation_sheet.dart';
import 'delivery_confirmation_sheet.dart';
import 'package:raouf26mobileapp/Utils/custom_snackbar.dart';

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
          padding: EdgeInsets.all(20.r),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F6F8),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              style: GoogleFonts.manrope(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: GoogleFonts.manrope(
                  color: Colors.grey.shade500,
                  fontSize: 15.sp,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.black87, size: 28.sp),
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
            children: [
              _buildFilterTab(0, "active".tr),
              SizedBox(width: 10.w),
              _buildFilterTab(1, "picked_up".tr),
              SizedBox(width: 10.w),
              _buildFilterTab(2, "in_transit".tr),
              SizedBox(width: 10.w),
              _buildFilterTab(3, "delivered".tr),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Tracking Cards
        Expanded(
          child: Obx(
            () => ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: controller.filteredPackages.length,
              itemBuilder: (context, index) {
                return _buildTrackingCard(controller.filteredPackages[index], context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTab(int index, String label) {
    return Obx(() {
      bool isSelected = controller.selectedFilterTab.value == index;
      return GestureDetector(
        onTap: () => controller.setFilterTab(index),
        child: Container(
          height: 48.h,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF4A80F0)
                : (isDarkMode ? Colors.transparent : Colors.white),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade300,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : (isDarkMode ? Colors.white70 : Colors.black54),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTrackingCard(TrackingPackageModel package, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
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
                    radius: 24.r,
                    backgroundImage: NetworkImage(package.userImage),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.userName,
                        style: GoogleFonts.manrope(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        package.id,
                        style: GoogleFonts.manrope(
                          fontSize: 13.sp,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "€${package.price.toStringAsFixed(0)}",
                style: GoogleFonts.manrope(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Status Timeline Card
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withOpacity(0.03) : const Color(0xFFF9FAFC),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: _buildStatusTimeline(package.currentStatusStep),
          ),
          SizedBox(height: 20.h),

          // Route Details
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withOpacity(0.03) : const Color(0xFFF9FAFC),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                _buildRouteItem(
                  icon: AppIcons.departure,
                  label: "Pickup",
                  location: "${package.fromCity} \u2022 Paris", // Static Paris as in screenshot
                  time: package.fromTime,
                  isLast: false,
                ),
                _buildRouteItem(
                  icon: AppIcons.location,
                  label: "Drop-off",
                  location: "${package.toCity} \u2022 Berlin", // Static Berlin as in screenshot
                  time: package.toTime,
                  isLast: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.to(() => TransporterTripDetailsView(package: package, controller: controller));
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    side: BorderSide(color: Colors.grey.shade200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    "View Details",
                    style: GoogleFonts.manrope(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _onCTAPressed(context, package),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    backgroundColor: const Color(0xFF4A80F0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    _getCTAText(package.currentStatusStep),
                    style: GoogleFonts.manrope(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
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

  Widget _buildRouteItem({
    required String icon,
    required String label,
    required String location,
    required String time,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white10 : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  if (!isDarkMode)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 4,
                    ),
                ],
              ),
              child: SvgPicture.asset(
                icon,
                width: 18.w,
                colorFilter: ColorFilter.mode(
                  isDarkMode ? Colors.white70 : Colors.black54,
                  BlendMode.srcIn,
                ),
              ),
            ),
            if (!isLast)
              Container(
                height: 30.h,
                width: 2.w,
                child: CustomPaint(
                  painter: DottedLinePainter(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.manrope(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    time,
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ),
              Text(
                location,
                style: GoogleFonts.manrope(
                  fontSize: 13.sp,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (!isLast) SizedBox(height: 12.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusTimeline(int currentStep) {
    const steps = ["Booked", "Picked Up", "In Transit", "Delivered"];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(steps.length, (index) {
            bool isReached = index <= currentStep;
            return Text(
              steps[index],
              style: GoogleFonts.manrope(
                fontSize: 11.sp,
                fontWeight: isReached ? FontWeight.w700 : FontWeight.w500,
                color: isReached
                    ? (isDarkMode ? Colors.white : Colors.black)
                    : Colors.grey.shade400,
              ),
            );
          }),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 2.h,
                width: double.infinity,
                color: Colors.grey.shade200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(steps.length, (index) {
                  bool isReached = index <= currentStep;
                  bool isCompleted = index < currentStep;
                  return Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      color: isCompleted ? const Color(0xFF4A80F0) : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isReached ? const Color(0xFF4A80F0) : Colors.grey.shade200,
                        width: isReached ? 3.w : 2.w,
                      ),
                      boxShadow: [
                        if (isReached)
                          BoxShadow(
                            color: const Color(0xFF4A80F0).withOpacity(0.2),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                      ],
                    ),
                  );
                }),
              ),
              // Blue active line
              Positioned(
                left: 0,
                child: Container(
                  height: 2.h,
                  width: (Get.width - 84.w) * (currentStep / (steps.length - 1)),
                  color: const Color(0xFF4A80F0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getCTAText(int statusStep) {
    switch (statusStep) {
      case 0: return 'Mark as Picked Up';
      case 1: return 'Mark in Transit';
      case 2: return 'Mark as Delivered';
      case 3: default: return 'View Proof';
    }
  }

  void _onCTAPressed(BuildContext context, TrackingPackageModel package) {
    switch (package.currentStatusStep) {
      case 0:
        showPickupConfirmationSheet(context, package, controller);
        break;
      case 1:
        // Transition to In Transit
        controller.updatePackageStatus(package.id, 2);
        CustomSnackbar.success(
          title: "Success",
          message: "Package is now in transit!",
        );
        break;
      case 2:
        showDeliveryConfirmationSheet(context, package, controller);
        break;
      default:
        break;
    }
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;
  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 3, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
