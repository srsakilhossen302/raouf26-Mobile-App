import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ComplianceFlowController extends GetxController {
  final RxInt currentStep = 0.obs;
  final bool isDarkMode;
  final String userRole; // "Transporter" or "Traveler"
  final bool isAccountVerified;
  final bool isAgreementAccepted;
  final bool isAgreementExpired;

  ComplianceFlowController({
    required this.isDarkMode,
    this.userRole = "Traveler",
    this.isAccountVerified = false,
    this.isAgreementAccepted = false,
    this.isAgreementExpired =
        true, // Default to true for testing/demo as requested
  });

  List<Map<String, String>> get filteredSteps {
    List<Map<String, String>> activeSteps = [];

    // Step 1: Draft (Always show if something is missing)
    if (!isAccountVerified || !isAgreementAccepted || isAgreementExpired) {
      String draftDesc = "Your trip has been saved. ";
      if (!isAccountVerified && !isAgreementAccepted) {
        draftDesc +=
            "Complete verification and sign the agreement to publish it.";
      } else if (!isAccountVerified) {
        draftDesc += "Complete verification to publish it.";
      } else if (isAgreementExpired) {
        draftDesc += "Renew your agreement to publish it.";
      } else {
        draftDesc += "Sign the agreement to publish it.";
      }

      activeSteps.add({
        "title": "Trip Saved as Draft",
        "description":
            "$draftDesc\n\nYou can come back and finish this anytime from your drafts.",
        "buttonText": "Complete Required Steps",
      });
    }

    // Step 2: Verification (If missing)
    if (!isAccountVerified) {
      activeSteps.add({
        "title": "Verify Your Account",
        "description":
            "To publish trips and receive delivery requests please verify your account first.\n\nVerification helps keep Sendit safe and trusted for everyone.",
        "buttonText": "Verify My Account",
      });
    }

    // Step 3: Agreement (If missing) - Role based
    if (!isAgreementAccepted) {
      activeSteps.add({
        "title": "Accept the $userRole Agreement",
        "description":
            "Before publishing trips, you need to review and accept the $userRole agreement. This sets clear rules and responsibilities for both you and the sender.",
        "buttonText": "Review & Sign",
      });
    }

    // Step 4: Expired (If expired)
    if (isAgreementExpired) {
      activeSteps.add({
        "title": "Agreement Expired",
        "description":
            "Your transport agreement has expired. To continue publishing trips and receiving bookings please renew it.\n\nRenewing your agreement keeps your account active and helps ensure smooth trip management.",
        "buttonText": "Renew My Agreement",
      });
    }

    return activeSteps;
  }

  void nextStep() {
    if (currentStep.value < filteredSteps.length - 1) {
      currentStep.value++;
    } else {
      Get.back();
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
  final String userRole;

  const ComplianceSheet({
    super.key,
    required this.isDarkMode,
    this.userRole = "Traveler",
  });

  static void show(bool isDarkMode, {String role = "Traveler"}) {
    Get.bottomSheet(
      ComplianceSheet(isDarkMode: isDarkMode, userRole: role),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // In a real app, these would come from an AuthController or UserProfile
    final controller = Get.put(
      ComplianceFlowController(
        isDarkMode: isDarkMode,
        userRole: userRole,
        isAccountVerified: false, // Mock value
        isAgreementAccepted: false, // Mock value
        isAgreementExpired: true, // New Mock value for "Agreement Expired"
      ),
    );

    return Obx(() {
      final steps = controller.filteredSteps;
      final step = steps[controller.currentStep.value];
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
