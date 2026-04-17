import 'package:flutter/material.dart' hide TimePickerDialog;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controllers/publish_trip_flow_controller.dart';
import 'time_picker_dialog.dart';

class TripDetailsStep extends StatelessWidget {
  final PublishTripFlowController controller;
  final bool isDarkMode;

  const TripDetailsStep({
    super.key,
    required this.controller,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
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
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
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
          Obx(
            () => _buildDateField(
              label: "Departure Time",
              hint: "Select Time",
              value: controller.departureTime.value,
              isDarkMode: isDarkMode,
              onTap: () => Get.dialog(
                TimePickerDialog(
                  controller: controller,
                  isDeparture: true,
                  isDarkMode: isDarkMode,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "Add a Stop (Optional)",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          _buildStopItem("40, Sidi Bu Jafar, Sousse, Tunisia", isDarkMode),
          _buildStopItem("40, Sidi Bu Jafar, Sousse, Tunisia", isDarkMode),
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
          Obx(
            () => _buildDateField(
              label: "Arrival Time",
              hint: "Select Time",
              value: controller.arrivalTime.value,
              isDarkMode: isDarkMode,
              onTap: () => Get.dialog(
                TimePickerDialog(
                  controller: controller,
                  isDeparture: false,
                  isDarkMode: isDarkMode,
                ),
              ),
            ),
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
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          onChanged: (value) {
            if (label == "From") {
              this.controller.departureText.value = value;
            } else if (label == "To") {
              this.controller.destinationText.value = value;
            }
          },
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
            color: isDarkMode ? Colors.white : Colors.black,
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

  Widget _buildStopItem(String location, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDarkMode ? Colors.white24 : const Color(0xFFE0E0E0),
          ),
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
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
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
}
