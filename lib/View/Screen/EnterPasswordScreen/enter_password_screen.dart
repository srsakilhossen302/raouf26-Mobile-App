import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../ForgotPasswordScreen/forgot_password_screen.dart';

class EnterPasswordScreen extends StatefulWidget {
  const EnterPasswordScreen({super.key});

  @override
  State<EnterPasswordScreen> createState() => _EnterPasswordScreenState();
}

class _EnterPasswordScreenState extends State<EnterPasswordScreen> {
  bool _isObscure = true;

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
          "Enter Password",
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
              "Enter Your Password",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Enter your password to access your account.",
              style: TextStyle(
                fontSize: 16.sp,
                color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              "Password",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              obscureText: _isObscure,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Enter Your Password',
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
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: isDarkMode ? Colors.white54 : Colors.grey.shade600,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.to(() => const ForgotPasswordScreen()),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: const Color(0xFF4A80F0),
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Log In",
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
