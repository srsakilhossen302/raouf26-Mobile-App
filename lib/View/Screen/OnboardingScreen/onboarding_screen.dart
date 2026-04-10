import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../LogInScreen/login_screen.dart';
import '../SignUpScreen/signup_screen.dart';

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
      "title": "Welcome to Sendit",
      "desc":
          "Connect with trusted travelers to send packages or earn money on your trips.",
    },
    {
      "image": AppImg.onboarding2,
      "title": "Ship With Confidence",
      "desc": "Track your packages in real-time and enjoy secure payments.",
    },
    {
      "image": AppImg.onboarding3,
      "title": "Turn Your Trips Into Earnings",
      "desc":
          "Make money by delivering items while you travel to your destination.",
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
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.white24
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.translate,
                          size: 16.sp,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "EN / FR",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
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
                              onboardingData[index]["title"]!,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              onboardingData[index]["desc"]!,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.grey.shade600,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            // Buttons
                            SizedBox(
                              width: double.infinity,
                              height: 55.h,
                              child: ElevatedButton(
                                onPressed: () =>
                                    Get.to(() => const SignUpScreen()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4A80F0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            SizedBox(
                              width: double.infinity,
                              height: 55.h,
                              child: OutlinedButton(
                                onPressed: () =>
                                    Get.to(() => const LogInScreen()),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: isDarkMode
                                        ? Colors.white24
                                        : Colors.grey.shade300,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
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
