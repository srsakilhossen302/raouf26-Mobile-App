import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PublishTripFlowController extends GetxController {
  final RxInt currentStep = 0.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<DateTime> focusedDate = DateTime.now().obs;

  final departureController = TextEditingController();
  final destinationController = TextEditingController();
  final RxString departureTime = "".obs;
  final RxString arrivalTime = "".obs;
  final RxList<String> stops = <String>[].obs;

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }

  void clearSelection() {
    selectedDate.value = null;
  }
}

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
            return _buildCalendarStep(context, controller, isDarkMode);
          case 1:
            return _buildDetailsStep(context, controller, isDarkMode);
          case 2:
            return _buildSummaryStep(context, controller, isDarkMode);
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
        if (controller.currentStep.value == 1) return const SizedBox();
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
              controller.currentStep.value == 2 ? "Publish" : "Next",
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

  Widget _buildCalendarStep(
    BuildContext context,
    PublishTripFlowController controller,
    bool isDarkMode,
  ) {
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
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        DateFormat(
                          'd MMM',
                        ).format(controller.selectedDate.value!),
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () => controller.clearSelection(),
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.white10
                              : const Color(0xFFF5F5F5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 20),
                      ),
                    ),
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
                            _buildMiniInput(Icons.location_on, isDarkMode),
                            SizedBox(height: 8.h),
                            _buildMiniInput(Icons.near_me, isDarkMode),
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

  Widget _buildMiniInput(IconData icon, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(children: [Icon(icon, size: 16, color: Colors.grey)]),
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

  Widget _buildDetailsStep(
    BuildContext context,
    PublishTripFlowController controller,
    bool isDarkMode,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Departure & Destination",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () => controller.previousStep(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Text(
            "Set your starting point and final destination for this trip.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24.h),
          _buildTextField(
            label: "From",
            hint: "Enter departure location",
            controller: controller.departureController,
            isDarkMode: isDarkMode,
            suffixIcon: Icons.map_outlined,
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.location_searching,
              size: 16,
              color: Color(0xFF4A80F0),
            ),
            label: Text(
              "Use my current location",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                color: const Color(0xFF4A80F0),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          _buildDateField(
            label: "Departure Time",
            hint: "Select Time",
            value: controller.departureTime.value,
            isDarkMode: isDarkMode,
            onTap: () => _showTimePicker(context, controller, true),
          ),
          SizedBox(height: 24.h),
          Text(
            "Add a Stop (Optional)",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          _buildStopItem("40, Sidi Bu Jafar, Sousse, Tunisia"),
          _buildStopItem("40, Sidi Bu Jafar, Sousse, Tunisia"),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.add_location_outlined,
              size: 16,
              color: Colors.grey,
            ),
            label: Text(
              "Add a Stop",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          _buildTextField(
            label: "To",
            hint: "Enter destination location",
            controller: controller.destinationController,
            isDarkMode: isDarkMode,
            suffixIcon: Icons.map_outlined,
          ),
          SizedBox(height: 16.h),
          _buildDateField(
            label: "Arrival Time",
            hint: "Select Time",
            value: controller.arrivalTime.value,
            isDarkMode: isDarkMode,
            onTap: () => _showTimePicker(context, controller, false),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.nextStep(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A80F0),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildSummaryStep(
    BuildContext context,
    PublishTripFlowController controller,
    bool isDarkMode,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Publish Your Trip",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "List your journey and accept delivery requests from trusted senders.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24.h),
          // Calendar View summary (simplified)
          _buildSummaryCard(controller, isDarkMode),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: _buildSummaryBox(
                  "Departure & Destination",
                  "Tunisia",
                  Icons.location_on,
                  isDarkMode,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  children: [
                    _buildSummaryMiniBox(
                      "Set Price & Capacity",
                      "Price / kg",
                      isDarkMode,
                    ),
                    SizedBox(height: 12.h),
                    _buildSummaryMiniBox(
                      "Set Travel Details",
                      "e.g. flight, boat etc.",
                      isDarkMode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isDarkMode,
    IconData? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.plusJakartaSans(color: Colors.grey),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: Colors.grey)
                : null,
            filled: true,
            fillColor: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required String hint,
    required String value,
    required bool isDarkMode,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value.isEmpty ? hint : value,
                  style: GoogleFonts.plusJakartaSans(
                    color: value.isEmpty
                        ? Colors.grey
                        : (isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
                const Icon(Icons.access_time, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStopItem(String location) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.circle_outlined,
              size: 16,
              color: Color(0xFF4A80F0),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                location,
                style: GoogleFonts.plusJakartaSans(fontSize: 12.sp),
              ),
            ),
            const Icon(Icons.menu, size: 16, color: Colors.grey),
            SizedBox(width: 8.w),
            const Icon(Icons.close, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showTimePicker(
    BuildContext context,
    PublishTripFlowController controller,
    bool isDeparture,
  ) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    int selectedHour = 6;
    int selectedMinute = 30;
    String selectedPeriod = "PM";

    Get.dialog(
      Dialog(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
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
      ),
    );
  }

  Widget _buildSummaryCard(
    PublishTripFlowController controller,
    bool isDarkMode,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "February, 2026",
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(
    String title,
    String value,
    IconData icon,
    bool isDarkMode,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(icon, size: 16, color: const Color(0xFF4A80F0)),
              SizedBox(width: 8.w),
              Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryMiniBox(String title, String hint, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            hint,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
