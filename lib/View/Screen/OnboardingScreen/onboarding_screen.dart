import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../LogInScreen/login_screen.dart';

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
    bool isDarkMode = Get.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Logo and Language Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AppIcons.logo,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                      isDarkMode ? Colors.white : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.white24
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.translate,
                          size: 16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "EN / FR",
                          style: TextStyle(
                            fontSize: 12,
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: List.generate(
                  onboardingData.length,
                  (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 4,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? const Color(0xFF4A80F0)
                            : (isDarkMode
                                  ? Colors.white24
                                  : Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(2),
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
                        height: Get.height * 0.35,
                        fit: BoxFit.contain,
                      ),
                      const Spacer(),
                      // Bottom Sheet Style Content
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color(0xFF1E1E1E)
                              : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode
                                  ? Colors.black54
                                  : Colors.black12,
                              blurRadius: 20,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Container(
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.white24
                                      : Colors.grey.shade300,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              onboardingData[index]["title"]!,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              onboardingData[index]["desc"]!,
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.grey.shade600,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Buttons
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4A80F0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "Create Account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 55,
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
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16,
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
