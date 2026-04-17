import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import '../Controllers/publish_trip_flow_controller.dart';

class ReviewPublishStep extends StatelessWidget {
  final PublishTripFlowController controller;
  final bool isDarkMode;

  const ReviewPublishStep({
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
            "Review & Publish",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "Check your trip details before publishing and receiving delivery requests.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
          SizedBox(height: 24.h),

          // Route Details
          _buildReviewCard(
            title: "Route Details",
            isDarkMode: isDarkMode,
            child: Column(
              children: [
                // Map Placeholder
                Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.1)
                        : const Color(0xFFE8EAED),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Stack(
                    children: [
                      // Departure Point Label
                      Positioned(
                        left: 20.w,
                        top: 30.h,
                        child: _buildMapLabel("Departure Point"),
                      ),
                      // Departure Icon
                      Positioned(
                        left: 45.w,
                        top: 55.h,
                        child: _buildMapIcon(
                          Icons.near_me,
                          const Color(0xFF4A80F0),
                        ),
                      ),

                      // Drop Point Label
                      Positioned(
                        right: 60.w,
                        top: 15.h,
                        child: _buildMapLabel("Drop Point"),
                      ),
                      // Drop Icon
                      Positioned(
                        right: 80.w,
                        top: 40.h,
                        child: _buildMapIcon(
                          Icons.location_on,
                          const Color(0xFF4A80F0),
                        ),
                      ),

                      // Adjust Location Button
                      Positioned(
                        bottom: 12.h,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 14.sp,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  "Adjust Location",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                _buildRouteItem(
                  iconPath: AppIcons.trackingNavbar,
                  label: "Departure: ${controller.departureController.text}",
                  isDarkMode: isDarkMode,
                ),
                SizedBox(height: 16.h),
                _buildRouteItem(
                  iconPath: AppIcons.location,
                  label:
                      "Destination: ${controller.destinationController.text}",
                  isDarkMode: isDarkMode,
                ),
                if (controller.stops.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  const Divider(height: 1),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Stops",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        controller.stops.join(", "),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Date & Time
          _buildReviewCard(
            title: "Date & Time",
            showEdit: true,
            onEdit: () => controller.currentStep.value = 0,
            isDarkMode: isDarkMode,
            child: Column(
              children: [
                _buildInfoRow(
                  "Departure Date",
                  controller.selectedDate.value != null
                      ? controller.selectedDate.value.toString().split(' ')[0]
                      : "N/A",
                  isDarkMode,
                  showDivider: true,
                ),
                _buildInfoRow(
                  "Departure Time",
                  controller.departureTime.value,
                  isDarkMode,
                  showDivider: true,
                ),
                _buildInfoRow(
                  "Arrival Time",
                  controller.arrivalTime.value,
                  isDarkMode,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Capacity Details
          _buildReviewCard(
            title: "Capacity Details",
            showEdit: true,
            onEdit: () => controller.currentStep.value = 2,
            isDarkMode: isDarkMode,
            child: Column(
              children: [
                _buildInfoRow(
                  "Item Type",
                  controller.canCarryPackages.value ? "Packages" : "Documents",
                  isDarkMode,
                  showDivider: true,
                ),
                _buildInfoRow(
                  "Available Space",
                  "${controller.capacityController.text} kg",
                  isDarkMode,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Price Details
          _buildReviewCard(
            title: "Price Details",
            showEdit: true,
            onEdit: () => controller.currentStep.value = 2,
            isDarkMode: isDarkMode,
            child: Column(
              children: [
                if (controller.canCarryDocuments.value)
                  _buildInfoRow(
                    "Documents / per document",
                    "${controller.pricePerDocumentController.text} ${controller.selectedCurrency.value}",
                    isDarkMode,
                    showDivider: controller.canCarryPackages.value,
                  ),
                if (controller.canCarryPackages.value)
                  _buildInfoRow(
                    "Packages / per kg",
                    "${controller.pricePerPackageController.text} ${controller.selectedCurrency.value}",
                    isDarkMode,
                  ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Trip Rules & Notes
          _buildReviewCard(
            title: "Trip Rules & Notes",
            showEdit: true,
            onEdit: () => controller.currentStep.value = 5,
            isDarkMode: isDarkMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  "Items Type",
                  controller.selectedWhatYouAccept.join(", "),
                  isDarkMode,
                  showDivider:
                      controller.rules.isNotEmpty ||
                      controller.tripDescriptionController.text.isNotEmpty,
                ),
                ...controller.rules.asMap().entries.map(
                  (entry) => _buildInfoRow(
                    "Rule ${entry.key + 1}.",
                    entry.value,
                    isDarkMode,
                    showDivider:
                        entry.key != controller.rules.length - 1 ||
                        controller.tripDescriptionController.text.isNotEmpty,
                  ),
                ),
                if (controller.tripDescriptionController.text.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Description & Notes",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 24.w),
                      Expanded(
                        child: Text(
                          controller.tripDescriptionController.text,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? Colors.white : Colors.black,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildMapLabel(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMapIcon(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 16.sp),
    );
  }

  Widget _buildReviewCard({
    required String title,
    required Widget child,
    required bool isDarkMode,
    bool showEdit = false,
    VoidCallback? onEdit,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.white.withOpacity(0.05)
            : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.1),
        ),
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
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                ),
              ),
              if (showEdit)
                GestureDetector(
                  onTap: onEdit,
                  child: SvgPicture.asset(
                    AppIcons.edit,
                    width: 18.w,
                    height: 18.w,
                    colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  Widget _buildRouteItem({
    required String iconPath,
    required String label,
    required bool isDarkMode,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SvgPicture.asset(
            iconPath,
            width: 16.w,
            height: 16.w,
            colorFilter: ColorFilter.mode(
              const Color(0xFF4A80F0),
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    bool isDarkMode, {
    bool showDivider = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.1),
          ),
      ],
    );
  }
}
