import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Controllers/publish_trip_flow_controller.dart';

class CalendarStep extends StatelessWidget {
  final PublishTripFlowController controller;
  final bool isDarkMode;

  const CalendarStep({
    super.key,
    required this.controller,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Publish Your Trip",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "List your journey and accept delivery requests from trusted senders.",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    color: isDarkMode
                        ? Colors.white70
                        : const Color(0xFF666666),
                  ),
                ),
                SizedBox(height: 24.h),

                // Calendar List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4, // Show 4 months
                  itemBuilder: (context, index) {
                    DateTime monthDate = DateTime(
                      DateTime.now().year,
                      DateTime.now().month + index,
                      1,
                    );
                    return Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.05)
                              : const Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: TableCalendar(
                          firstDay: DateTime.now().subtract(
                            const Duration(days: 30),
                          ),
                          lastDay: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                          focusedDay: monthDate,
                          currentDay: DateTime.now(),
                          headerVisible: true,
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: false,
                            titleTextStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            leftChevronVisible: false,
                            rightChevronVisible: false,
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                            weekendStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                          calendarStyle: CalendarStyle(
                            defaultTextStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 14.sp,
                            ),
                            weekendTextStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 14.sp,
                            ),
                            selectedDecoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            todayDecoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            outsideDaysVisible: false,
                          ),
                          selectedDayPredicate: (day) =>
                              isSameDay(controller.selectedDate.value, day),
                          onDaySelected: (selectedDay, focusedDay) {
                            controller.selectedDate.value = selectedDay;
                            controller.focusedDate.value = focusedDay;
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        // Selection UI (Image 2)
        Obx(() {
          if (controller.selectedDate.value == null) return const SizedBox();
          return Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => controller.currentStep.value = 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              DateFormat('EEE, d MMM')
                                  .format(controller.selectedDate.value!)
                                  .toUpperCase(),
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (controller.departureTime.value.isNotEmpty) ...[
                              Text(
                                " - Dep. ${controller.departureTime.value}",
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                            if (controller.arrivalTime.value.isNotEmpty) ...[
                              Text(
                                " - Arr. ${controller.arrivalTime.value}",
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Clear selection button removed as per request to remove all back/close icons in flow
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Departure & Destination Card
                    Expanded(
                      flex: 4,
                      child: _buildSelectionCard(
                        isDarkMode: isDarkMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0F4FF),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: const Icon(
                                Icons.route_outlined,
                                color: Color(0xFF4A80F0),
                                size: 18,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              "Departure & Destination",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Obx(
                              () => _buildMiniInput(
                                Icons.location_on,
                                controller.departureText.value.isEmpty
                                    ? "Departure"
                                    : controller.departureText.value,
                                isDarkMode,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Obx(
                              () => _buildMiniInput(
                                Icons.near_me,
                                controller.destinationText.value.isEmpty
                                    ? "Destination"
                                    : controller.destinationText.value,
                                isDarkMode,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Right Column
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          _buildSelectionCard(
                            isDarkMode: isDarkMode,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Set Price & Capacity",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildMiniTextField(
                                        "Price/ kg",
                                        isDarkMode,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: _buildMiniTextField(
                                        "e.g. 10 kg",
                                        isDarkMode,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          _buildSelectionCard(
                            isDarkMode: isDarkMode,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Set Travel Details",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                _buildMiniTextField(
                                  "e.g. flight, boat etc.",
                                  isDarkMode,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSelectionCard({
    required Widget child,
    required bool isDarkMode,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: child,
    );
  }

  Widget _buildMiniInput(IconData icon, String text, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10.sp,
                color: text == "Departure" || text == "Destination"
                    ? Colors.grey
                    : (isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniTextField(String hint, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        hint,
        style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: Colors.grey),
      ),
    );
  }
}
