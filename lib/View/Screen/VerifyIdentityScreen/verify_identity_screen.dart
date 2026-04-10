import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerifyIdentityScreen extends StatelessWidget {
  const VerifyIdentityScreen({super.key});

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
          "Verify Your Identity",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              "Verify Your Identity",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "To protect your account, we'll need a few details.",
              style: TextStyle(
                fontSize: 16.sp,
                color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 32.h),
            _inputLabel(label: "Full Name", isDarkMode: isDarkMode),
            SizedBox(height: 12.h),
            _textField(hint: "Full Name", isDarkMode: isDarkMode),
            SizedBox(height: 20.h),
            _inputLabel(label: "Email", isDarkMode: isDarkMode),
            SizedBox(height: 12.h),
            _textField(hint: "Email", isDarkMode: isDarkMode),
            SizedBox(height: 20.h),
            _inputLabel(label: "Last Trip Reference (optional)", isDarkMode: isDarkMode),
            SizedBox(height: 12.h),
            _textField(hint: "Enter Your Last Trip", isDarkMode: isDarkMode),
            SizedBox(height: 100.h), // Adjust spacing as per image
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: () {
                  // Submit request logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Submit Request",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _inputLabel({required String label, required bool isDarkMode}) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _textField({required String hint, required bool isDarkMode}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
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
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black,
        fontSize: 16.sp,
      ),
    );
  }
}
