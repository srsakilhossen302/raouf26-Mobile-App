import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ComplianceFlowController extends GetxController {
  final RxInt currentStep = 0.obs;
  final bool isDarkMode;

  ComplianceFlowController({required this.isDarkMode});

  final List<Map<String, String>> steps = [
    {
      "title": "Trip Saved as Draft",
      "description":
          "Your trip has been saved. Complete verification or sign the agreement to publish it.\n\nYou can come back and finish this anytime from your drafts.",
      "buttonText": "Complete Required Steps",
    },
    {
      "title": "Verify Your Account",
      "description":
          "To publish trips and receive delivery requests please verify your account first.\n\nVerification helps keep Sendit safe and trusted for everyone.",
      "buttonText": "Verify My Account",
    },
    {
      "title": "Accept the Transport Agreement",
      "description":
          "Before publishing trips, you need to review and accept the agreement. This sets clear rules and responsibilities for both you and the sender.",
      "buttonText": "Review & Sign",
    },
    {
      "title": "Agreement Expired",
      "description":
          "Your transport agreement has expired. To continue publishing trips and receiving bookings please renew it.\n\nRenewing your agreement keeps your account active and helps ensure smooth trip management.",
      "buttonText": "Renew My Agreement",
    },
  ];

  void nextStep() {
    if (currentStep.value < steps.length - 1) {
      currentStep.value++;
    } else {
      Get.back(); // Close the flow
      Get.snackbar(
        "Success",
        "Trip Published Successfully!",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class ComplianceSheet extends StatelessWidget {
  final bool isDarkMode;

  const ComplianceSheet({super.key, required this.isDarkMode});

  static void show(bool isDarkMode) {
    Get.bottomSheet(
      ComplianceSheet(isDarkMode: isDarkMode),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ComplianceFlowController(isDarkMode: isDarkMode),
    );

    return Obx(() {
      final step = controller.steps[controller.currentStep.value];
      return Container(
        width: double.infinity,
        height: 0.9.sh, // "bro popap" - Covers 90% of the screen
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Info Icon & Close Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  ),
                  child: Icon(
                    Icons.info_outline,
                    size: 22.sp,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.delete<ComplianceFlowController>();
                    Get.back();
                  },
                  child: Icon(
                    Icons.close,
                    size: 28.sp,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),

            // Title
            Text(
              step["title"]!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16.h),

            // Description
            Text(
              step["description"]!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15.sp,
                color: Colors.grey[600],
                height: 1.6,
              ),
            ),

            const Spacer(),

            // Image
            Center(
              child: Image.asset(
                "assets/images/Verify Your Account- img.png",
                width: 280.w,
                height: 280.w,
                fit: BoxFit.contain,
              ),
            ),

            const Spacer(),

            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.nextStep(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  step["buttonText"]!,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      );
    });
  }
}
