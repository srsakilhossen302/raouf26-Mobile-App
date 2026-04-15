import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/transporter_tracking_controller.dart';
import 'delivery_confirmation_sheet.dart';

void showPickupConfirmationSheet(BuildContext context, TrackingPackageModel package) {
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  // A simple standalone RxInt to manage the selected condition
  var selectedConditionIndex = 1.obs; // Default to minor visible damage selected for mockup
  
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
              padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w, bottom: 10.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    "Pickup Confirmation (${package.id})",
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
                      child: Icon(Icons.close, color: isDarkMode ? Colors.white : Colors.black, size: 24.sp),
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
                      "Confirm Pickup",
                      style: GoogleFonts.montserrat(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Verify the parcel and record its condition before confirming pickup.",
                      style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Upload Pickup Proof
                    Text(
                      "Upload Pickup Proof",
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
                        color: isDarkMode ? Colors.white10 : const Color(0xFFF8F9FB),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 30.sp),
                          SizedBox(height: 8.h),
                          Text(
                            "Take a photo or upload",
                            style: GoogleFonts.montserrat(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Package Condition
                    Text(
                      "Package Condition",
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Obx(() => _buildConditionRadioTile("Package in good condition", 0, selectedConditionIndex, isDarkMode)),
                    SizedBox(height: 8.h),
                    Obx(() => _buildConditionRadioTile("Minor visible damage", 1, selectedConditionIndex, isDarkMode)),
                    SizedBox(height: 8.h),
                    Obx(() => _buildConditionRadioTile("Damaged parcel or packaging", 2, selectedConditionIndex, isDarkMode)),
                    SizedBox(height: 24.h),

                    // Add Note (Optional)
                    Row(
                      children: [
                        Text(
                          "Add Note ",
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
                        color: isDarkMode ? Colors.white10 : const Color(0xFFF8F9FB),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        maxLines: null,
                        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                          hintText: "Type here ...",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 13.sp),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
                          showDeliveryConfirmationSheet(context, package);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A80F0),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        ),
                        child: Text(
                          "Confirm Pickup",
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20.h),
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

Widget _buildConditionRadioTile(String title, int index, RxInt selectedIndex, bool isDarkMode) {
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
                color: isSelected ? Colors.blue : (isDarkMode ? Colors.white38 : Colors.grey.shade400),
                width: isSelected ? 5.w : 1.w,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
