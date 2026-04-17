import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controllers/publish_trip_flow_controller.dart';
import '../Widgets/calendar_step.dart';
import '../Widgets/trip_details_step.dart';
import '../Widgets/prices_capacity_step.dart';
import '../Widgets/travel_details_step.dart';
import '../Widgets/trip_summary_step.dart';
import '../Widgets/trip_rules_step.dart';
import '../Widgets/review_publish_step.dart';
import '../Widgets/compliance_sheet.dart';
import 'compliance_page.dart';

class PublishTripFlowScreen extends StatelessWidget {
  const PublishTripFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PublishTripFlowController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Publish Your Trip",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
          ),
        ),
      ),
      body: Obx(() {
        switch (controller.currentStep.value) {
          case 0:
            return CalendarStep(controller: controller, isDarkMode: isDarkMode);
          case 1:
            return TripDetailsStep(
              controller: controller,
              isDarkMode: isDarkMode,
            );
          case 2:
            return PricesCapacityStep(
              controller: controller,
              isDarkMode: isDarkMode,
            );
          case 3:
            return TravelDetailsStep(
              controller: controller,
              isDarkMode: isDarkMode,
            );
          case 4:
            return TripSummaryStep(
              controller: controller,
              isDarkMode: isDarkMode,
            );
          case 5:
            return TripRulesStep(
              controller: controller,
              isDarkMode: isDarkMode,
            );
          case 6:
            return ReviewPublishStep(
              controller: controller,
              isDarkMode: isDarkMode,
            );
          default:
            return const SizedBox();
        }
      }),
      bottomNavigationBar: Obx(() {
        if (controller.currentStep.value == 1 ||
            controller.currentStep.value == 2 ||
            controller.currentStep.value == 3) {
          return const SizedBox();
        }

        if (controller.currentStep.value == 0 &&
            controller.selectedDate.value == null) {
          return Padding(
            padding: EdgeInsets.all(24.w),
            child: ElevatedButton(
              onPressed: null, // Disabled when no date selected
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A80F0).withOpacity(0.5),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: const Text("Next", style: TextStyle(color: Colors.white)),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.all(24.w),
          child: ElevatedButton(
            onPressed: () {
              if (controller.currentStep.value == 6) {
                // Show Compliance Flow in a big popup (Bottom Sheet)
                ComplianceSheet.show(isDarkMode);
              } else {
                controller.nextStep();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A80F0),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              controller.currentStep.value == 6
                  ? "Publish My Trip"
                  : controller.currentStep.value == 5
                  ? "Review"
                  : "Next",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        );
      }),
    );
  }
}
