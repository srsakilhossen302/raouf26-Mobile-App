import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/PackageDetails/package_details_controller.dart';

class PackageDetailsScreen extends GetView<PackageDetailsController> {
  const PackageDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PackageDetailsController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Delivery Details",
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: Colors.grey.shade200,
            height: 1.h,
            alignment: Alignment.centerLeft,
            child: Container(width: 0.3.sw, color: const Color(0xFF4A80F0)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Package Information",
              style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Enter the size, weight, and photos of your package.",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24.h),

            // Package Size Section
            _sectionTitle("Package Size", isDarkMode),
            SizedBox(height: 16.h),
            Obx(
              () => Column(
                children: [
                  _sizeOption("Small", "( 1 to 10 kg )", isDarkMode),
                  SizedBox(height: 12.h),
                  _sizeOption("Medium", "( 20 to 50 kg )", isDarkMode),
                  SizedBox(height: 12.h),
                  _sizeOption("Large", "( 60 to 120 kg )", isDarkMode),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            _sectionTitle("Or Enter Exact Weight", isDarkMode),
            SizedBox(height: 12.h),
            _customTextField(
              hintText: "Enter Custom Weight",
              suffix: "kg",
              isDarkMode: isDarkMode,
            ),

            SizedBox(height: 24.h),
            _sectionTitle("Package Content", isDarkMode),
            SizedBox(height: 12.h),
            _customTextField(
              hintText: "e.g. Decoration Pieces",
              isDarkMode: isDarkMode,
            ),

            SizedBox(height: 24.h),
            _sectionTitle("What Kind of Package?", isDarkMode),
            Text(
              "You can select multiple categories",
              style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => Row(
                  children: [
                    _categoryChip(
                      "Food",
                      "assets/icons/Food-Icons.svg",
                      isDarkMode,
                    ),
                    SizedBox(width: 12.w),
                    _categoryChip(
                      "Clothes",
                      "assets/icons/Clothes-icons.svg",
                      isDarkMode,
                    ),
                    SizedBox(width: 12.w),
                    _categoryChip(
                      "Documents",
                      "assets/icons/Documents-icons.svg",
                      isDarkMode,
                    ),
                    SizedBox(width: 12.w),
                    _categoryChip(
                      "Medicines",
                      "assets/icons/Medicines-icons.svg",
                      isDarkMode,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),
            _sectionTitle("Package Photos", isDarkMode),
            Text(
              "Please provide the photos of the package's exterior and interior for verification.",
              style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Obx(
                  () => _photoUploadBox(
                    "Exterior",
                    isDarkMode,
                    controller.exteriorImage.value,
                    () => controller.pickImage(true),
                  ),
                ),
                SizedBox(width: 16.w),
                Obx(
                  () => _photoUploadBox(
                    "Interior",
                    isDarkMode,
                    controller.interiorImage.value,
                    () => controller.pickImage(false),
                  ),
                ),
              ],
            ),

            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Need storage until pickup?",
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Obx(
                  () => Switch(
                    value: controller.needStorage.value,
                    onChanged: (val) => controller.toggleStorage(val),
                    activeColor: const Color(0xFF4A80F0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                "If your package is large or requires special handling (e.g. furniture), you may need to pay for storage until pickup.",
                style: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ),

            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "3 Days of Storage",
                        style: GoogleFonts.montserrat(
                          fontSize: 10.sp,
                          color: const Color(0xFF4A80F0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.storageDateRange.value,
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.black54,
                    size: 20.sp,
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Continue",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, bool isDarkMode) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: isDarkMode ? Colors.white : Colors.black87,
      ),
    );
  }

  Widget _sizeOption(String title, String subtitle, bool isDarkMode) {
    bool isSelected = controller.selectedSize.value == title;
    return GestureDetector(
      onTap: () => controller.updateSize(title),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.white.withOpacity(0.05)
              : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF4A80F0) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$title ",
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: subtitle,
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 20.r,
              height: 20.r,
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
                        width: 10.r,
                        height: 10.r,
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

  Widget _customTextField({
    required String hintText,
    String? suffix,
    required bool isDarkMode,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.white.withOpacity(0.05)
            : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14.sp,
            color: Colors.grey.shade400,
          ),
          border: InputBorder.none,
          suffixText: suffix,
          suffixStyle: GoogleFonts.montserrat(
            fontSize: 14.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _categoryChip(String title, String iconPath, bool isDarkMode) {
    bool isSelected = controller.selectedCategories.contains(title);
    return GestureDetector(
      onTap: () => controller.toggleCategory(title),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4A80F0).withOpacity(0.1)
              : (isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : const Color(0xFFF9FAFB)),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF4A80F0) : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 16.sp,
              height: 16.sp,
              colorFilter: ColorFilter.mode(
                isSelected ? const Color(0xFF4A80F0) : Colors.black54,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF4A80F0)
                    : (isDarkMode ? Colors.white70 : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photoUploadBox(
    String label,
    bool isDarkMode,
    File? image,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.white.withOpacity(0.05)
                : const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(16.r),
            image: image != null
                ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
                : null,
          ),
          child: image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Camera=icons.svg",
                      width: 28.sp,
                      height: 28.sp,
                      colorFilter: ColorFilter.mode(
                        Colors.grey.shade400,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      label,
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
