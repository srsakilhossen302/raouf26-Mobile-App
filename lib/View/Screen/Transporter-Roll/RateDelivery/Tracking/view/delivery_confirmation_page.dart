import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/transporter_tracking_controller.dart';
import 'delivery_completed_page.dart';
import 'package:raouf26mobileapp/Utils/custom_snackbar.dart';

class DeliveryConfirmationPage extends StatelessWidget {
  final TrackingPackageModel package;
  final TransporterTrackingController controller;
  
  DeliveryConfirmationPage({super.key, required this.package, required this.controller});

  final RxInt selectedConditionIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Delivery Confirmation (${package.id})',
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirm Delivery',
              style: GoogleFonts.manrope(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Are you sure you want to mark this package as delivered?',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                color: isDarkMode ? Colors.white60 : Colors.grey.shade600,
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),

            // Verify Parcel Section
            _buildSectionTitle('Verify Parcel', isDarkMode),
            SizedBox(height: 4.h),
            _buildSectionSubtitle('Scan the parcel QR code to confirm delivery.\nIf unavailable, upload proof manually.', isDarkMode),
            SizedBox(height: 20.h),

            // Scan QR Code Button
            _buildButton(
              onPressed: () {},
              icon: Icons.qr_code_scanner_rounded,
              label: 'Scan QR Code',
              color: const Color(0xFF4A80F0),
              textColor: Colors.white,
            ),
            SizedBox(height: 12.h),

            // Upload Proof Button
            _buildButton(
              onPressed: () {},
              icon: Icons.camera_alt_outlined,
              label: 'Upload Proof Instead',
              color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF8F9FB),
              textColor: isDarkMode ? Colors.white70 : Colors.grey.shade700,
              isOutlined: true,
            ),
            SizedBox(height: 24.h),

            // Recipient Name
            _buildSectionTitle('Recipient Name', isDarkMode),
            SizedBox(height: 12.h),
            _buildInput(package.userName.isNotEmpty ? package.userName : 'Mukaram H.', isDarkMode),
            SizedBox(height: 24.h),

            // Signature
            _buildSectionTitle('Signature', isDarkMode, optional: true),
            SizedBox(height: 12.h),
            _buildInput('Type here...', isDarkMode, height: 100.h),
            SizedBox(height: 24.h),
            
            // Package Condition
            _buildSectionTitle('Package Condition', isDarkMode),
            SizedBox(height: 16.h),
            Column(
              children: [
                _buildConditionTile('Package in good condition', 0, isDarkMode),
                SizedBox(height: 12.h),
                _buildConditionTile('Minor damage observed', 1, isDarkMode),
                SizedBox(height: 12.h),
                _buildConditionTile('Damaged parcel', 2, isDarkMode),
              ],
            ),
            SizedBox(height: 24.h),

            // Add Note
            _buildSectionTitle('Add Note', isDarkMode, optional: true),
            SizedBox(height: 12.h),
            _buildInput('Type here...', isDarkMode, height: 80.h),
            SizedBox(height: 40.h),

            // Confirm Delivery Button
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: () {
                  controller.updatePackageStatus(package.id, 3);
                  Get.to(() => DeliveryCompletedPage(package: package));
                  CustomSnackbar.success(
                    title: "Success",
                    message: "Package delivered successfully!",
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text(
                  'Confirm Delivery',
                  style: GoogleFonts.manrope(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode, {bool optional = false}) {
    return RichText(
      text: TextSpan(
        text: title,
        style: GoogleFonts.manrope(fontSize: 15.sp, fontWeight: FontWeight.w700, color: isDarkMode ? Colors.white : Colors.black),
        children: [
          if (optional)
            TextSpan(text: ' (Optional)', style: GoogleFonts.manrope(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSectionSubtitle(String text, bool isDarkMode) {
    return Text(
      text,
      style: GoogleFonts.manrope(fontSize: 13.sp, color: isDarkMode ? Colors.white38 : Colors.grey.shade500, height: 1.4),
    );
  }

  Widget _buildInput(String hint, bool isDarkMode, {double? height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        maxLines: height != null ? null : 1,
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.w),
        ),
      ),
    );
  }

  Widget _buildButton({required VoidCallback onPressed, required IconData icon, required String label, required Color color, required Color textColor, bool isOutlined = false}) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: isOutlined 
        ? OutlinedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, color: Colors.grey, size: 22.sp),
            label: Text(label, style: GoogleFonts.manrope(fontSize: 15.sp, fontWeight: FontWeight.w600, color: textColor)),
            style: OutlinedButton.styleFrom(
              backgroundColor: color,
              side: BorderSide.none,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          )
        : ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, color: Colors.white, size: 22.sp),
            label: Text(label, style: GoogleFonts.manrope(fontSize: 15.sp, fontWeight: FontWeight.w600, color: textColor)),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
    );
  }

  Widget _buildConditionTile(String title, int index, bool isDarkMode) {
    return Obx(() {
      bool isSelected = selectedConditionIndex.value == index;
      return GestureDetector(
        onTap: () => selectedConditionIndex.value = index,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: isSelected 
              ? (isDarkMode ? Colors.blue.withOpacity(0.1) : const Color(0xFFF5F8FF))
              : (isDarkMode ? Colors.white.withOpacity(0.03) : const Color(0xFFF9FAFB)),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? const Color(0xFF4A80F0) : (isDarkMode ? Colors.white10 : Colors.transparent),
              width: 1.w,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF4A80F0) : (isDarkMode ? Colors.white24 : Colors.grey.shade300),
                    width: 1.5.w,
                  ),
                ),
                child: isSelected 
                  ? Center(child: Container(width: 10.w, height: 10.w, decoration: const BoxDecoration(color: Color(0xFF4A80F0), shape: BoxShape.circle)))
                  : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}
