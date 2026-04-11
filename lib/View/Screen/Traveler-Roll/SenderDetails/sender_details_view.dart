import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/SenderDetails/sender_details_controller.dart';
import 'package:raouf26mobileapp/utils/appicons/app_icons.dart';

class SenderDetailsView extends GetView<SenderDetailsController> {
  const SenderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SenderDetailsController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Delivery Details",
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: Colors.grey.shade200,
            height: 1.h,
            alignment: Alignment.centerLeft,
            child: Container(
              width: 0.6.sw, // Second step out of 3
              color: const Color(0xFF4A80F0),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sender Details",
              style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Add the sender's information and pickup details.",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24.h),

            // Sender Name Field
            _sectionTitle("Sender Name", isDarkMode),
            SizedBox(height: 12.h),
            _customTextField(
              controller: controller.senderNameController,
              hintText: "Enter Sender Name",
              suffixIcon: AppIcons.partion,
              isDarkMode: isDarkMode,
            ),

            SizedBox(height: 20.h),

            // Phone Number Field
            _sectionTitle("Phone Number", isDarkMode),
            SizedBox(height: 12.h),
            _phoneTextField(isDarkMode),

            SizedBox(height: 20.h),

            // Use My Details Button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: OutlinedButton(
                onPressed: () => controller.useMyDetails(),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Use My Details",
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Map Section
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  // Mock Map Container
                  Container(
                    height: 160.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                      image: const DecorationImage(
                        image: NetworkImage("https://static-maps.yandex.ru/1.x/?lang=en_US&ll=10.1658,36.8665&z=13&l=map&size=450,450"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.adjustLocation(),
                        icon: const Icon(Icons.location_on_outlined, size: 18, color: Colors.black),
                        label: Text(
                          "Adjust Location",
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Address Bar
                  Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(Icons.near_me_outlined, color: Colors.grey, size: 20.sp),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Obx(() => Text(
                            controller.selectedAddress.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          )),
                        ),
                        SvgPicture.asset(AppIcons.save, width: 20.w, height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Main Continue Button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to next screen or finish
                },
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
    );
  }

  Widget _sectionTitle(String title, bool isDarkMode) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _customTextField({
    required TextEditingController controller,
    required String hintText,
    String? suffixIcon,
    required bool isDarkMode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.montserrat(color: isDarkMode ? Colors.white : Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.montserrat(color: Colors.grey, fontSize: 14.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: EdgeInsets.all(12.r),
                  child: SvgPicture.asset(suffixIcon, width: 20.w, height: 20.h),
                )
              : null,
        ),
      ),
    );
  }

  Widget _phoneTextField(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            child: Row(
              children: [
                // Mock Flag (Tunisia from image)
                Container(
                  width: 24.w,
                  height: 16.h,
                  color: Colors.red,
                  child: const Center(child: Icon(Icons.star, size: 10, color: Colors.white)),
                ),
                SizedBox(width: 8.w),
                Text(
                  "+216",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(width: 1.w, height: 24.h, color: Colors.grey.shade300),
          Expanded(
            child: TextField(
              controller: controller.phoneNumberController,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.montserrat(color: isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: "00000000",
                hintStyle: GoogleFonts.montserrat(color: Colors.grey, fontSize: 14.sp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
