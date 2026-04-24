import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({super.key});

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  final TextEditingController descriptionController = TextEditingController();
  String selectedCategory = "App Issue";

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Report Issue',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 230),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/Report-icons.svg",
                  width: 80.w,
                  height: 80.w,
                  colorFilter: ColorFilter.mode(
                    isDarkMode
                        ? const Color.fromARGB(255, 235, 5, 5)
                        : const Color.fromARGB(255, 236, 40, 40),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Please include the following details in your report',
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            _buildTipItem("Select the issue category", isDarkMode),
            _buildTipItem("Provide detailed problem description", isDarkMode),
            SizedBox(height: 24.h),
            Text(
              'What is this Report About?',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                _buildCategoryChip("App Issue"),
                _buildCategoryChip("Account"),
                _buildCategoryChip("Payment"),
                _buildCategoryChip("Transporter Issue"),
                _buildCategoryChip("Others"),
              ],
            ),
            SizedBox(height: 24.h),
            Text(
              'Describe Issue',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Type here ...",
                hintStyle: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : const Color(0xFFF8F9FB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Add Attachment (Optional)',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () {
                Get.snackbar(
                  "Coming Soon",
                  "Image upload feature is under development",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.blueAccent,
                  colorText: Colors.white,
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 32.h),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.05)
                      : const Color(0xFFF8F9FB),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.description_outlined,
                      color: Colors.grey,
                      size: 40.sp,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Add Image or Document",
                      style: GoogleFonts.manrope(
                        fontSize: 13.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (descriptionController.text.trim().isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please describe the issue",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  Get.back();
                  Get.snackbar(
                    "Success",
                    "Your report has been submitted successfully",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
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
                  "Submit",
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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

  Widget _buildTipItem(String tip, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(Icons.circle, size: 4.sp, color: Colors.grey),
          SizedBox(width: 8.w),
          Text(
            tip,
            style: GoogleFonts.manrope(
              fontSize: 13.sp,
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    bool isSelected = selectedCategory == label;
    return InkWell(
      onTap: () => setState(() => selectedCategory = label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4A80F0)
              : (isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Colors.white
                : (isDarkMode ? Colors.white70 : Colors.black87),
          ),
        ),
      ),
    );
  }
}
