import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../LogInScreen/login_screen.dart';
import '../SignUpScreen/signup_screen.dart';
import '../ChooseRoleScreen/choose_role_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;


  final List<Map<String, String>> onboardingData = [
    {
      "image": AppImg.onboarding1,
      "title": "welcome_title",
      "desc": "welcome_subtitle",
    },
    {
      "image": AppImg.onboarding2,
      "title": "onboarding2_title",
      "desc": "onboarding2_desc",
    },
    {
      "image": AppImg.onboarding3,
      "title": "onboarding3_title",
      "desc": "onboarding3_desc",
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Logo and Language Selector
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AppIcons.logo,
                    height: 30.h,
                    colorFilter: ColorFilter.mode(
                      isDarkMode ? Colors.white : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),

            // Page Indicator
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                children: List.generate(
                  onboardingData.length,
                  (index) => Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? const Color(0xFF4A80F0)
                            : (isDarkMode
                                  ? Colors.white24
                                  : Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Onboarding Content (Image and Description)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Spacer(),
                      Image.asset(
                        onboardingData[index]["image"]!,
                        height: 320.h,
                        fit: BoxFit.contain,
                      ),
                      const Spacer(),
                      // Bottom Sheet Style Content
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(30.r),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color(0xFF1E1E1E)
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode
                                  ? Colors.black54
                                  : Colors.black12,
                              blurRadius: 20.r,
                              offset: Offset(0, -5.h),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Container(
                                width: 40.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.white24
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2.r),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              onboardingData[index]["title"]!.tr,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              onboardingData[index]["desc"]!.tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.grey.shade600,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            // Updated Get Started CTA with App Theme Blue Color
                            GestureDetector(
                              onTap: () =>
                                  Get.to(() => const ChooseRoleScreen()),
                              child: Container(
                                width: double.infinity,
                                height: 65.h,
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? const Color(0xFF1E1E1E)
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(40.r),
                                  border: isDarkMode
                                      ? Border.all(color: Colors.white10)
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 24.w),
                                    Text(
                                      "continue_button".tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const Spacer(),
                                    Container(
                                      height: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF4A80F0,
                                        ), // App Primary Blue
                                        borderRadius: BorderRadius.circular(
                                          30.r,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "get_started".tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
