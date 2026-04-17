import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_picker/country_picker.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import '../Controllers/publish_trip_flow_controller.dart';

class PricesCapacityStep extends StatelessWidget {
  final PublishTripFlowController controller;
  final bool isDarkMode;

  const PricesCapacityStep({
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
                "Set Your Prices & Capacity",
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
            "Choose your delivery price and set the maximum capacity for this trip.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24.h),

          // Select Currency
          Text(
            "Select Currency",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Obx(
            () => GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    controller.selectedCountryName.value = country.name;
                    controller.selectedCountryFlag.value = country.flagEmoji;
                    // Note: country_picker doesn't provide currency code directly.
                    // You might need a mapping or another package for full currency support.
                    controller.selectedCurrency.value = country.countryCode;
                  },
                  countryListTheme: CountryListThemeData(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                    inputDecoration: InputDecoration(
                      hintText: 'Search country',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? Colors.white10
                          : const Color(0xFFF5F7FA),
                    ),
                    backgroundColor: isDarkMode
                        ? const Color(0xFF1E1E1E)
                        : Colors.white,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Text(
                      controller.selectedCountryFlag.value,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        "${controller.selectedCountryName.value} (${controller.selectedCurrency.value})",
                        style: GoogleFonts.plusJakartaSans(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Price Per Document
          _buildTextField(
            label: "Price Per Document",
            hint: "Enter Price",
            controller: controller.pricePerDocumentController,
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 24.h),

          // Price Per Package or kg
          _buildTextField(
            label: "Price Per Package or kg",
            hint: "Enter Price",
            controller: controller.pricePerPackageController,
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 24.h),

          // What Can You Carry?
          Text(
            "What Can You Carry?",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          Obx(
            () => _buildCarryOption(
              icon: AppIcons.documents,
              label: "Documents",
              isSelected: controller.canCarryDocuments.value,
              onTap: () => controller.canCarryDocuments.toggle(),
              isDarkMode: isDarkMode,
            ),
          ),
          SizedBox(height: 12.h),
          Obx(
            () => _buildCarryOption(
              icon: AppIcons.delivery,
              label: "Packages",
              isSelected: controller.canCarryPackages.value,
              onTap: () => controller.canCarryPackages.toggle(),
              isDarkMode: isDarkMode,
            ),
          ),
          SizedBox(height: 24.h),

          // Available Space
          Text(
            "Available Space",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: controller.capacityController,
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: "Enter Weight e.g. 10 kg",
              hintStyle: GoogleFonts.plusJakartaSans(color: Colors.grey),
              suffixText: "kg",
              suffixStyle: GoogleFonts.plusJakartaSans(color: Colors.grey),
              filled: true,
              fillColor: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
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

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isDarkMode,
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

  Widget _buildCarryOption({
    required String icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4A80F0)
                : (isDarkMode ? Colors.white10 : const Color(0xFFE0E0E0)),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon,
                width: 20.w,
                height: 20.w,
                colorFilter: ColorFilter.mode(
                  isDarkMode ? Colors.white70 : Colors.black87,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4A80F0)
                      : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4A80F0),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
