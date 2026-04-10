import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../VerifyIdentityScreen/verify_identity_screen.dart';

class UpdateNumberScreen extends StatelessWidget {
  const UpdateNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          "Update Your Number",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              "Update Your Number",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Make sure the country code and number are correct.",
              style: TextStyle(
                fontSize: 16.sp,
                color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              "Phone Number",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            IntlPhoneField(
              decoration: InputDecoration(
                hintText: '00000000',
                hintStyle: TextStyle(
                  color: isDarkMode ? Colors.white24 : Colors.grey.shade400,
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
              initialCountryCode: 'TN',
              onChanged: (phone) {
                // Handle phone number change
              },
              dropdownIconPosition: IconPosition.trailing,
              showCountryFlag: true,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 16.sp,
              ),
              dropdownTextStyle: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: const Color(0xFF4A80F0).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info,
                    color: Color(0xFF4A80F0),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      "Double-check your country code and number format to ensure you receive the verification code.",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const VerifyIdentityScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
