import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../../Utils/AppIcons/app_icons.dart';
import '../Screen/Traveler-Roll/PublishTrips/Widgets/booking_details_modal.dart';
import 'custom_reject_button.dart';
import '../../../../../Utils/custom_snackbar.dart';

class BookingRequestCard extends StatelessWidget {
  final String userName;
  final String userImage;
  final String timeAgo;
  final String status;
  final String fromCity;
  final String toCity;
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String toTime;
  final String packageSize;
  final String packageStatus;
  final String totalPrice;
  final List<String>? packagePhotos;
  final String? fromIcon;
  final String? toIcon;
  final List<String>? rejectionReasons;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onViewDetails;

  const BookingRequestCard({
    super.key,
    required this.userName,
    required this.userImage,
    required this.timeAgo,
    required this.status,
    required this.fromCity,
    required this.toCity,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.packageSize,
    required this.packageStatus,
    required this.totalPrice,
    this.onAccept,
    this.onReject,
    this.packagePhotos,
    this.fromIcon,
    this.toIcon,
    this.rejectionReasons,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                backgroundImage: NetworkImage(userImage),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          userName,
                          style: GoogleFonts.manrope(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        SvgPicture.asset(
                          AppIcons.verifa,
                          width: 14.w,
                          colorFilter: ColorFilter.mode(
                            const Color(0xFF4A80F0),
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      timeAgo,
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        color: isDarkMode ? Colors.white60 : const Color(0xFF9E9E9E),
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
                  style: GoogleFonts.manrope(
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
            icon: fromIcon ?? AppIcons.departure,
            city: fromCity,
            date: fromDate,
            time: fromTime,
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
            icon: toIcon ?? AppIcons.location,
            city: toCity,
            date: toDate,
            time: toTime,
            isFirst: false,
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 10.h),
          _buildDetailRow("Package Size", packageSize, isDarkMode),
          _buildDetailRow(
            "Status",
            packageStatus,
            isDarkMode,
            isUrgent: packageStatus.toLowerCase() == "urgent",
          ),
          if (packagePhotos != null && packagePhotos!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              "Package Photos",
              style: GoogleFonts.manrope(
                fontSize: 12.sp,
                color: isDarkMode ? Colors.white38 : const Color(0xFF9E9E9E),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: packagePhotos!
                  .map((url) => Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: _buildPackagePhoto(url),
                      ))
                  .toList(),
            ),
          ],
          _buildDetailRow(
            "Total Estimate",
            totalPrice,
            isDarkMode,
            isBold: true,
          ),
          SizedBox(height: 20.h),
          if (status == "Accepted")
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onViewDetails,
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
            )
          else
            Row(
              children: [
                Expanded(
                  child: CustomRejectButton(
                    onPressed: onReject ?? () => _showInternalRejectSheet(context, isDarkMode),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept ?? () => Get.to(() => const BookingDetailsScreen()),
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
                      style: GoogleFonts.manrope(
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

  void _showInternalRejectSheet(BuildContext context, bool isDarkMode) {
    final RxString selectedReason = "".obs;
    final List<String> defaultReasons = rejectionReasons ?? [
      "Sorry, we are no longer available for this date.",
      "The package size or weight is not suitable.",
      "I have changed my travel route.",
      "Other"
    ];

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "Reject Request",
              style: GoogleFonts.manrope(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Please select a reason for rejecting this request.",
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                color: isDarkMode ? Colors.white60 : const Color(0xFF666666),
              ),
            ),
            SizedBox(height: 24.h),
            Column(
              children: defaultReasons.map((reason) {
                return Obx(() {
                  bool isSelected = selectedReason.value == reason;
                  return GestureDetector(
                    onTap: () => selectedReason.value = reason,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF4A80F0).withOpacity(0.1)
                            : (isDarkMode
                                ? Colors.white.withOpacity(0.05)
                                : const Color(0xFFF5F7FA)),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF4A80F0)
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              reason,
                              style: GoogleFonts.manrope(
                                fontSize: 14.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: isSelected
                                    ? const Color(0xFF4A80F0)
                                    : (isDarkMode
                                        ? Colors.white
                                        : const Color(0xFF1A1A1A)),
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: const Color(0xFF4A80F0),
                              size: 20.sp,
                            ),
                        ],
                      ),
                    ),
                  );
                });
              }).toList(),
            ),
            SizedBox(height: 12.h),
            Obx(() {
              if (selectedReason.value == "Other") {
                return Container(
                  margin: EdgeInsets.only(bottom: 24.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Type your reason here...",
                      hintStyle: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
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
                      "Cancel",
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color:
                            isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      // Built-in success message
                      CustomSnackbar.error(
                        title: "Request Rejected",
                        message: "The request has been declined.",
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A80F0),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Confirm Reject",
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildPackagePhoto(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.network(
        url,
        width: 80.w,
        height: 80.w,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 80.w,
          height: 80.w,
          color: Colors.grey.shade100,
          child: Icon(Icons.broken_image, color: Colors.grey, size: 24.sp),
        ),
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
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              width: 18.w,
              height: 18.w,
              colorFilter: ColorFilter.mode(
                isDarkMode ? Colors.white70 : const Color(0xFF666666),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
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
                  color: const Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: GoogleFonts.manrope(
            fontSize: 12.sp,
            color: isDarkMode ? Colors.white70 : const Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
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
            style: GoogleFonts.manrope(
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
                style: GoogleFonts.manrope(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFF79009),
                ),
              ),
            )
          else
            Text(
              value,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
                color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
              ),
            ),
        ],
      ),
    );
  }
}
