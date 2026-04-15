import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/rate_delivery_controller.dart';

void showRateDeliverySheet(BuildContext context) {
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  Get.put(RateDeliveryController());

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            // Handlebar
            Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white24 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rate This Delivery",
                      style: GoogleFonts.montserrat(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Your feedback helps improve the delivery experience.",
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      "How was your experience?",
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Icon(
                            Icons.star_rounded,
                            color: Colors.grey.shade300,
                            size: 40.sp,
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      "What did you like the most?",
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: [
                        _buildTag("Fast Delivery", isDarkMode),
                        _buildTag("Polite Attitude", isDarkMode),
                        _buildTag("Location Awareness", isDarkMode),
                        _buildTag("Responsive", isDarkMode),
                        _buildTag("Minimal Calling", isDarkMode),
                        _buildTag("Neat & Clean", isDarkMode),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      "Share more about your experience",
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.all(16.r),
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.05)
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: TextField(
                        maxLines: null,
                        style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                          hintText: "Write your feedback here...",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade400, fontSize: 14.sp),
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // Submit Review Button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          // Add submission logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A80F0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Submit Review",
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
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

Widget _buildTag(String label, bool isDarkMode) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(
        color: isDarkMode ? Colors.white24 : Colors.grey.shade300,
      ),
    ),
    child: Text(
      label,
      style: GoogleFonts.montserrat(
        fontSize: 12.sp,
        color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
      ),
    ),
  );
}
