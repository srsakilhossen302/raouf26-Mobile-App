import 'package:flutter/material.dart' hide TimePickerDialog;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
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
                style: GoogleFonts.manrope(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          Text(
            "Set your starting point and final destination for this trip.",
            style: GoogleFonts.manrope(fontSize: 14.sp, color: Colors.grey),
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
              style: GoogleFonts.manrope(
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
          RichText(
            text: TextSpan(
              text: "Add a Stop ",
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              children: [
                TextSpan(
                  text: "(Optional)",
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                _buildStopRow(
                  "40, Sidi Bu Jafar, Sousse, Tunisia",
                  isDarkMode,
                  showDivider: true,
                ),
                _buildStopRow(
                  "40, Sidi Bu Jafar, Sousse, Tunisia",
                  isDarkMode,
                  showDivider: true,
                ),
                _buildAddStopAction(isDarkMode),
              ],
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
          style: GoogleFonts.manrope(
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
            hintStyle: GoogleFonts.manrope(color: Colors.grey),
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
          style: GoogleFonts.manrope(
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
                  style: GoogleFonts.manrope(
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

  Widget _buildStopRow(
    String location,
    bool isDarkMode, {
    bool isLast = false,
    bool showDivider = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF4A80F0),
                        width: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    width: 1.2,
                    height: 24.h,
                    child: Column(
                      children: List.generate(
                        4,
                        (index) => Expanded(
                          child: Container(
                            width: 1.2,
                            margin: EdgeInsets.symmetric(vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  location,
                  style: GoogleFonts.manrope(
                    fontSize: 13.sp,
                    color: isDarkMode ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(Icons.drag_handle, size: 20.sp, color: Colors.grey.shade400),
              SizedBox(width: 12.w),
              Icon(Icons.close, size: 20.sp, color: Colors.grey.shade400),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            indent: 42.w,
            height: 1,
            color: isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.1),
          ),
      ],
    );
  }

  Widget _buildAddStopAction(bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          SvgPicture.asset(
            AppIcons.location,
            width: 18.w,
            colorFilter: ColorFilter.mode(
              Colors.grey.shade500,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            "Add a Stop",
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
