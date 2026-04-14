import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import '../Controllers/publish_trip_flow_controller.dart';

class TravelDetailsStep extends StatelessWidget {
  final PublishTripFlowController controller;
  final bool isDarkMode;

  const TravelDetailsStep({
    super.key,
    required this.controller,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> travelModes = [
      {"label": "Flight", "icon": AppIcons.flight},
      {"label": "Car", "icon": AppIcons.car},
      {"label": "Train", "icon": AppIcons.train},
      {"label": "Bus", "icon": AppIcons.bus},
      {"label": "Boat", "icon": AppIcons.boat},
      {
        "label": "Other",
        "icon": AppIcons.inviteNew,
      }, // Using truck icon as placeholder for Other
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Travel Details",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.close,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          Text(
            "Tell us how you're traveling.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24.h),

          // Grid of Travel Modes
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 1.1,
            ),
            itemCount: travelModes.length,
            itemBuilder: (context, index) {
              final mode = travelModes[index];
              return Obx(() {
                final isSelected =
                    controller.selectedTravelMode.value == mode["label"];
                return GestureDetector(
                  onTap: () =>
                      controller.selectedTravelMode.value = mode["label"]!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.05)
                          : const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF4A80F0)
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFE8EFFF)
                                : (isDarkMode ? Colors.white10 : Colors.white),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            mode["icon"]!,
                            width: 28.w,
                            height: 28.w,
                            fit: BoxFit.contain,
                            placeholderBuilder: (context) => Icon(
                              Icons.directions_run,
                              size: 28.w,
                              color: Colors.grey,
                            ),
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? const Color(0xFF4A80F0)
                                  : (isDarkMode
                                        ? Colors.white60
                                        : const Color(0xFF424242)),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          mode["label"]!,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15.sp,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w600,
                            color: isSelected
                                ? const Color(0xFF4A80F0)
                                : (isDarkMode
                                      ? Colors.white70
                                      : const Color(0xFF424242)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
          SizedBox(height: 24.h),

          // Dynamic Fields based on Travel Mode
          Obx(() {
            switch (controller.selectedTravelMode.value) {
              case "Flight":
                return _buildFlightFields();
              case "Car":
                return _buildCarFields();
              case "Train":
                return _buildTrainFields();
              case "Bus":
                return _buildBusFields();
              case "Boat":
                return _buildBoatFields();
              case "Other":
                return _buildOtherFields();
              default:
                return const SizedBox.shrink();
            }
          }),

          SizedBox(height: 32.h),

          // Confirm Button
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
              child: Text(
                "Confirm",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildFlightFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Airline"),
        SizedBox(height: 8.h),
        Obx(
          () => _buildDropdown(
            value: controller.selectedAirline.value == "Select Airline"
                ? null
                : controller.selectedAirline.value,
            hint: "Select Airline",
            items: [
              "Emirates",
              "Qatar Airways",
              "Turkish Airlines",
              "Tunisair",
            ],
            onChanged: (newValue) {
              if (newValue != null) {
                controller.selectedAirline.value = newValue;
              }
            },
          ),
        ),
        SizedBox(height: 24.h),
        _buildTextField(
          label: "Flight Number",
          hint: "Enter Flight Number",
          controller: controller.flightNumberController,
        ),
        SizedBox(height: 24.h),
        _buildUploadSection("Upload Ticket (Optional)"),
      ],
    );
  }

  Widget _buildCarFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Vehicle Type"),
        SizedBox(height: 8.h),
        Obx(
          () => _buildDropdown(
            value: controller.selectedVehicleType.value == "Select Vehicle Type"
                ? null
                : controller.selectedVehicleType.value,
            hint: "Select Vehicle Type",
            items: ["Sedan", "SUV", "Van", "Coupe"],
            onChanged: (newValue) {
              if (newValue != null) {
                controller.selectedVehicleType.value = newValue;
              }
            },
          ),
        ),
        SizedBox(height: 24.h),
        _buildTextField(
          label: "License Plate (Optional)",
          hint: "Enter License Plate Number",
          controller: controller.licensePlateController,
        ),
      ],
    );
  }

  Widget _buildTrainFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          label: "Train Number",
          hint: "Enter Train Number",
          controller: controller.trainNumberController,
        ),
        SizedBox(height: 24.h),
        _buildUploadSection("Upload Ticket (Optional)"),
      ],
    );
  }

  Widget _buildBusFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          label: "Bus Number",
          hint: "Enter Bus Number",
          controller: controller.busNumberController,
        ),
        SizedBox(height: 24.h),
        _buildUploadSection("Upload Ticket (Optional)"),
      ],
    );
  }

  Widget _buildOtherFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          label: "Description",
          hint: "Enter Description",
          controller: controller.otherDescriptionController,
        ),
        SizedBox(height: 24.h),
        _buildUploadSection("Upload Proof (Required)", isRequired: true),
      ],
    );
  }

  Widget _buildBoatFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          label: "Vessel Name",
          hint: "Enter Vessel Name",
          controller: controller.vesselNameController,
        ),
        SizedBox(height: 24.h),
        _buildUploadSection("Upload Booking (Optional)"),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: GoogleFonts.plusJakartaSans(color: Colors.grey),
          ),
          isExpanded: true,
          dropdownColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          style: GoogleFonts.plusJakartaSans(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
          items: items.map((String val) {
            return DropdownMenuItem<String>(value: val, child: Text(val));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildUploadSection(String label, {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () {}, // Handle file picker
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 32.h),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFF0F0F0)),
            ),
            child: Column(
              children: [
                const Icon(Icons.file_present_outlined, color: Colors.grey),
                SizedBox(height: 12.h),
                Text(
                  "Click to Upload",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.plusJakartaSans(color: Colors.grey),
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
}
