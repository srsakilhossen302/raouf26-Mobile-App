import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'publish_trip_flow_controller.dart';
import 'Widgets/calendar_step.dart';
import 'Widgets/trip_details_step.dart';
import 'Widgets/prices_capacity_step.dart';
import 'Widgets/trip_summary_step.dart';

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
        centerTitle: true,
        leading: IconButton(
          onPressed: () => controller.previousStep(),
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
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
            return TripSummaryStep(
              controller: controller,
              isDarkMode: isDarkMode,
            );
          default:
            return const SizedBox();
        }
      }),
      bottomNavigationBar: Obx(() {
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
        if (controller.currentStep.value == 1 ||
            controller.currentStep.value == 2) {
          return const SizedBox();
        }
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: ElevatedButton(
            onPressed: () => controller.nextStep(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A80F0),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              controller.currentStep.value == 3 ? "Publish" : "Next",
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
