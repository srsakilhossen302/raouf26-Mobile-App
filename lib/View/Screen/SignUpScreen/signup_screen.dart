import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../LogInScreen/login_screen.dart';
import '../AgreeToTermsScreen/agree_to_terms_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
          "sign_up".tr,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              Get.changeThemeMode(
                isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              "create_your_account".tr,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "signup_subtitle".tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 32.h),
            _inputLabel(label: "full_name".tr, isDarkMode: isDarkMode),
            SizedBox(height: 12.h),
            _textField(hint: "full_name".tr, isDarkMode: isDarkMode),
            SizedBox(height: 20.h),
            _inputLabel(label: "email".tr, isDarkMode: isDarkMode),
            SizedBox(height: 12.h),
            _textField(hint: "email".tr, isDarkMode: isDarkMode),
            SizedBox(height: 20.h),
            _inputLabel(label: "phone_number".tr, isDarkMode: isDarkMode),
            SizedBox(height: 12.h),
            IntlPhoneField(
              decoration: InputDecoration(
                hintText: '00000000',
                hintStyle: TextStyle(
                  color: isDarkMode ? Colors.white24 : Colors.grey.shade400,
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
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const AgreeToTermsScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: isDarkMode ? Colors.white24 : Colors.grey.shade300,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "log_in_with".tr, // Reusing key
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isDarkMode ? Colors.white60 : Colors.grey.shade600,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: isDarkMode ? Colors.white24 : Colors.grey.shade300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            _socialButton(
              isDarkMode: isDarkMode,
              icon: AppIcons.google,
              label: "continue_with_google".tr,
              onTap: () {},
            ),
            SizedBox(height: 16.h),
            _socialButton(
              isDarkMode: isDarkMode,
              icon: AppIcons.apple,
              label: "continue_with_apple".tr,
              onTap: () {},
            ),
            SizedBox(height: 16.h),
            _socialButton(
              isDarkMode: isDarkMode,
              icon: AppIcons.whatsapp,
              label: "continue_with_whatsapp".tr,
              onTap: () {},
            ),
            SizedBox(height: 16.h),
            _socialButton(
              isDarkMode: isDarkMode,
              icon: AppIcons.facebook,
              label: "continue_with_facebook".tr,
              onTap: () {},
            ),
            SizedBox(height: 20.h),
            Center(
              child: GestureDetector(
                onTap: () => Get.to(() => const LogInScreen()),
                child: RichText(
                  text: TextSpan(
                    text: "${"already_have_account".tr} ",
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
                      fontSize: 14.sp,
                    ),
                    children: [
                      TextSpan(
                        text: "log_in".tr,
                        style: TextStyle(
                          color: const Color(0xFF4A80F0),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black,
        fontSize: 16.sp,
      ),
    );
  }

  Widget _socialButton({
    required bool isDarkMode,
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isDarkMode ? Colors.white24 : Colors.grey.shade300,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: isDarkMode
              ? Colors.white.withOpacity(0.02)
              : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon.endsWith('.svg')
                ? SvgPicture.asset(icon, height: 24.h)
                : Image.asset(icon, height: 24.h),
            SizedBox(width: 12.w),
            Text(
              label,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
