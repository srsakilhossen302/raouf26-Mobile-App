import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/transporter_tracking_controller.dart';
import 'delivery_confirmation_sheet.dart';

void showPickupConfirmationSheet(
  BuildContext context,
  TrackingPackageModel package,
) {
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  // A simple standalone RxInt to manage the selected condition
  var selectedConditionIndex =
      1.obs; // Default to minor visible damage selected for mockup

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.90, // Almost full screen
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 20.w,
                right: 20.w,
                bottom: 10.h,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: isDarkMode ? Colors.white : Colors.black,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Pickup Confirmation (${package.id})',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: isDarkMode ? Colors.white10 : Colors.grey.shade100),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm Pickup',
                      style: GoogleFonts.montserrat(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Are you sure you want to mark this package as picked up?',
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        color: isDarkMode ? Colors.white60 : Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Verify Parcel Section
                    Text(
                      'Verify Parcel',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Scan the parcel QR code to confirm pickup.\nIf unavailable, upload proof manually.',
                      style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        color: isDarkMode ? Colors.white38 : Colors.grey.shade500,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    
                    // Scan QR Code Button
                    SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // QR Scanner logic
                        },
                        icon: Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 22.sp),
                        label: Text(
                          'Scan QR Code',
                          style: GoogleFonts.montserrat(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A80F0),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    
                    // Upload Proof Button
                    SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Image picker logic
                        },
                        icon: Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 22.sp),
                        label: Text(
                          'Upload Proof Instead',
                          style: GoogleFonts.montserrat(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF8F9FB),
                          side: BorderSide.none,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Package Condition
                    Text(
                      'Package Condition',
                      style: GoogleFonts.montserrat(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(
                      () => _buildConditionRadioTile(
                        'package_good'.tr,
                        0,
                        selectedConditionIndex,
                        isDarkMode,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                      () => _buildConditionRadioTile(
                        'minor_damage'.tr,
                        1,
                        selectedConditionIndex,
                        isDarkMode,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                      () => _buildConditionRadioTile(
                        'damaged_parcel'.tr,
                        2,
                        selectedConditionIndex,
                        isDarkMode,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Add Note
                    RichText(
                      text: TextSpan(
                        text: 'Add Note',
                        style: GoogleFonts.montserrat(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '(Optional)',
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      height: 100.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF8F9FB),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        maxLines: null,
                        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Type here...',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),

                    // Confirm Pickup Button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.snackbar(
                            "Success",
                            "Package picked up successfully!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A80F0),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Confirm Pickup',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom + 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildConditionRadioTile(
  String title,
  int index,
  RxInt selectedIndex,
  bool isDarkMode,
) {
  bool isSelected = selectedIndex.value == index;
  return GestureDetector(
    onTap: () => selectedIndex.value = index,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 13.sp,
              color: isDarkMode ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? Colors.blue
                    : (isDarkMode ? Colors.white38 : Colors.grey.shade400),
                width: isSelected ? 5.w : 1.w,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
