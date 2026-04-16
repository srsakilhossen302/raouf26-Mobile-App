import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../helper/shared_preference_helper.dart';
import '../SignUpScreen/signup_screen.dart';
import '../Transporter-Roll/Home/view/transporter_home_view.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  String selectedRole = "Traveler"; // Default selection

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
          "choose_your_role".tr,
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
              "choose_your_role".tr,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "role_subtitle".tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 32.h),
            _roleOption(
              title: "i_am_transporter".tr,
              icon: AppIcons.transporte,
              role: "Transporter",
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 16.h),
            _roleOption(
              title: "i_am_traveler".tr,
              icon: AppIcons.traveler,
              role: "Traveler",
              isDarkMode: isDarkMode,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: () async {
                  await SharedPreferenceHelper.saveUserRole(selectedRole);
                  Get.to(() => const SignUpScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "continue_button".tr,
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

  Widget _roleOption({
    required String title,
    required String icon,
    required String role,
    required bool isDarkMode,
  }) {
    bool isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.white.withOpacity(0.05)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4A80F0)
                : (isDarkMode ? Colors.white12 : Colors.grey.shade200),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white10 : Colors.white,
                shape: BoxShape.circle,
                boxShadow: isDarkMode
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: SvgPicture.asset(
                icon,
                height: 24.r,
                width: 24.r,
                colorFilter: ColorFilter.mode(
                  isDarkMode ? Colors.white70 : Colors.grey.shade700,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            Container(
              height: 20.r,
              width: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4A80F0)
                      : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        height: 10.r,
                        width: 10.r,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4A80F0),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
