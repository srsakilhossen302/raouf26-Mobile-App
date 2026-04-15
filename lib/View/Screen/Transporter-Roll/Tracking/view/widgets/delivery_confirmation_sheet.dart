import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/transporter_tracking_controller.dart';

void showDeliveryConfirmationSheet(
  BuildContext context,
  TrackingPackageModel package,
) {
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    '${'delivery_confirmation'.tr} (${package.id})',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.close,
                        color: isDarkMode ? Colors.white : Colors.black,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: isDarkMode ? Colors.white24 : Colors.grey.shade200),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'confirm_delivery'.tr,
                      style: GoogleFonts.montserrat(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'confirm_delivery_q'.tr,
                      style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Upload Delivery Proof
                    Text(
                      'upload_delivery_proof'.tr,
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.white10
                            : const Color(0xFFF8F9FB),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.white24
                              : Colors.grey.shade300,
                          style: BorderStyle.none,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.grey,
                            size: 30.sp,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'take_photo_or_upload'.tr,
                            style: GoogleFonts.montserrat(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Recipient Name
                    Text(
                      'recipient_name'.tr,
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.white10
                            : const Color(0xFFF8F9FB),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: package.userName.isNotEmpty
                              ? package.userName
                              : 'enter_recipient_name'.tr,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Signature (Optional)
                    Row(
                      children: [
                        Text(
                          'signature'.tr,
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          'optional_label'.tr,
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.white10
                            : const Color(0xFFF8F9FB),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      // Mock signature area
                    ),
                    SizedBox(height: 24.h),

                    // Add Note (Optional)
                    Row(
                      children: [
                        Text(
                          'add_note'.tr,
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          "(Optional)",
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 100.h,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.white10
                            : const Color(0xFFF8F9FB),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        maxLines: null,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'type_here'.tr,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),

                    // Confirm Delivery Button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          // Logic for delivery confirm
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A80F0),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'confirm_delivery'.tr,
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
