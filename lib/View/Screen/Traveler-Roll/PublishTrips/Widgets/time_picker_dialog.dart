import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controllers/publish_trip_flow_controller.dart';

class TimePickerDialog extends StatelessWidget {
  final PublishTripFlowController controller;
  final bool isDeparture;
  final bool isDarkMode;

  const TimePickerDialog({
    super.key,
    required this.controller,
    required this.isDeparture,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    int selectedHour = 6;
    int selectedMinute = 30;
    String selectedPeriod = "PM";

    return Dialog(
      backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  Expanded(
                    child: Center(
                      child: Text(
                        isDeparture
                            ? "Select Departure Time"
                            : "Select Arrival Time",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              // Interactive Time Selection UI
              SizedBox(
                height: 150.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 50.h,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.05)
                            : const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Hours Wheel
                        SizedBox(
                          width: 50.w,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 50.h,
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            controller: FixedExtentScrollController(
                              initialItem: selectedHour - 1,
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedHour = index + 1;
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 12,
                              builder: (context, index) {
                                final isSelected = selectedHour == index + 1;
                                return Center(
                                  child: Text(
                                    (index + 1).toString().padLeft(2, '0'),
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: isSelected ? 24.sp : 18.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? (isDarkMode
                                                ? Colors.white
                                                : Colors.black)
                                          : Colors.grey.withOpacity(0.4),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Text(
                          ":",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        // Minutes Wheel
                        SizedBox(
                          width: 50.w,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 50.h,
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            controller: FixedExtentScrollController(
                              initialItem: selectedMinute,
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedMinute = index;
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 60,
                              builder: (context, index) {
                                final isSelected = selectedMinute == index;
                                return Center(
                                  child: Text(
                                    index.toString().padLeft(2, '0'),
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: isSelected ? 24.sp : 18.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? (isDarkMode
                                                ? Colors.white
                                                : Colors.black)
                                          : Colors.grey.withOpacity(0.4),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        // AM/PM Wheel
                        SizedBox(
                          width: 60.w,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 50.h,
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            controller: FixedExtentScrollController(
                              initialItem: selectedPeriod == "AM" ? 0 : 1,
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedPeriod = index == 0 ? "AM" : "PM";
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 2,
                              builder: (context, index) {
                                final period = index == 0 ? "AM" : "PM";
                                final isSelected = selectedPeriod == period;
                                return Center(
                                  child: Text(
                                    period,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: isSelected ? 24.sp : 18.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? (isDarkMode
                                                ? Colors.white
                                                : Colors.black)
                                          : Colors.grey.withOpacity(0.4),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final timeStr =
                        "${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod";
                    if (isDeparture) {
                      controller.departureTime.value = timeStr;
                    } else {
                      controller.arrivalTime.value = timeStr;
                    }
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A80F0),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "Confirm",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
