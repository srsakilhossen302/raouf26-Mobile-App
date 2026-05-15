import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/transporter_tracking_controller.dart';
import 'package:raouf26mobileapp/Utils/custom_snackbar.dart';

void showDeliveryConfirmationSheet(
  BuildContext context,
  TrackingPackageModel package,
  TransporterTrackingController controller,
) {
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final RxBool isCompleted = false.obs;
  final RxInt selectedConditionIndex = 0.obs;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Obx(() {
        return Container(
          height: MediaQuery.of(context).size.height * 0.92,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FB),
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          ),
          child: isCompleted.value 
            ? _buildCompletedView(context, package, controller, isDarkMode)
            : _buildConfirmationForm(context, package, controller, isDarkMode, isCompleted, selectedConditionIndex),
        );
      });
    },
  );
}

Widget _buildConfirmationForm(
  BuildContext context,
  TrackingPackageModel package,
  TransporterTrackingController controller,
  bool isDarkMode,
  RxBool isCompleted,
  RxInt selectedConditionIndex,
) {
  return Column(
    children: [
      // Header
      Padding(
        padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w, bottom: 10.h),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios,
                color: isDarkMode ? Colors.white : Colors.black,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Delivery Confirmation (${package.id})',
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
      Divider(color: isDarkMode ? Colors.white10 : Colors.grey.shade100),

      Expanded(
        child: SingleChildScrollView(
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
              Text(
                'Verify Parcel',
                style: GoogleFonts.manrope(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Scan the parcel QR code to confirm delivery.\nIf unavailable, upload proof manually.',
                style: GoogleFonts.manrope(
                  fontSize: 13.sp,
                  color: isDarkMode ? Colors.white38 : Colors.grey.shade500,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 20.h),

              // Scan QR Code Button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 22.sp),
                  label: Text(
                    'Scan QR Code',
                    style: GoogleFonts.manrope(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A80F0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Upload Proof Button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 22.sp),
                  label: Text(
                    'Upload Proof Instead',
                    style: GoogleFonts.manrope(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF8F9FB),
                    side: BorderSide.none,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Recipient Name
              Text(
                'Recipient Name',
                style: GoogleFonts.manrope(fontSize: 15.sp, fontWeight: FontWeight.w700, color: isDarkMode ? Colors.white : Colors.black),
              ),
              SizedBox(height: 12.h),
              _buildSimpleInput(package.userName.isNotEmpty ? package.userName : 'Mukaram H.', isDarkMode),
              SizedBox(height: 24.h),

              // Signature
              RichText(
                text: TextSpan(
                  text: 'Signature',
                  style: GoogleFonts.manrope(fontSize: 15.sp, fontWeight: FontWeight.w700, color: isDarkMode ? Colors.white : Colors.black),
                  children: [
                    TextSpan(text: '(Optional)', style: GoogleFonts.manrope(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey)),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              _buildSimpleInput('Type here...', isDarkMode, height: 100.h),
              SizedBox(height: 24.h),
              
              // Package Condition
              Text(
                'package_condition'.tr,
                style: GoogleFonts.manrope(fontSize: 16.sp, fontWeight: FontWeight.w700, color: isDarkMode ? Colors.white : Colors.black),
              ),
              SizedBox(height: 16.h),
              Column(
                children: [
                  _buildConditionRadioTile('package_good'.tr, 0, selectedConditionIndex, isDarkMode),
                  SizedBox(height: 12.h),
                  _buildConditionRadioTile('minor_damage'.tr, 1, selectedConditionIndex, isDarkMode),
                  SizedBox(height: 12.h),
                  _buildConditionRadioTile('damaged_parcel'.tr, 2, selectedConditionIndex, isDarkMode),
                  Obx(() => selectedConditionIndex.value == 2 ? Padding(padding: EdgeInsets.only(top: 12.h), child: _buildUploadDamagePhoto(isDarkMode)) : const SizedBox()),
                ],
              ),
              SizedBox(height: 24.h),

              // Add Note
              RichText(
                text: TextSpan(
                  text: 'Add Note',
                  style: GoogleFonts.manrope(fontSize: 15.sp, fontWeight: FontWeight.w700, color: isDarkMode ? Colors.white : Colors.black),
                  children: [
                    TextSpan(text: '(Optional)', style: GoogleFonts.manrope(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey)),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              _buildSimpleInput('Type here...', isDarkMode, height: 80.h),
              SizedBox(height: 40.h),

              // Confirm Delivery Button
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    controller.updatePackageStatus(package.id, 3);
                    isCompleted.value = true;
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
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20.h),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildSimpleInput(String hint, bool isDarkMode, {double? height}) {
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

Widget _buildCompletedView(
  BuildContext context,
  TrackingPackageModel package,
  TransporterTrackingController controller,
  bool isDarkMode,
) {
  return Column(
    children: [
      // Handle bar
      SizedBox(height: 12.h),
      Container(
        width: 40.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white24 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
      
      // Header
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 24), // Spacer
            Text(
              'Delivery Completed',
              style: GoogleFonts.manrope(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Icon(
              Icons.format_list_bulleted_rounded,
              color: isDarkMode ? Colors.white70 : Colors.black87,
              size: 24.sp,
            ),
          ],
        ),
      ),

      Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              // Main Info Card
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundImage: NetworkImage(package.userImage),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                package.userName,
                                style: GoogleFonts.manrope(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                package.id,
                                style: GoogleFonts.manrope(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '€${package.price.toInt()}',
                          style: GoogleFonts.manrope(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        _buildActionIcon(Icons.send_rounded, isDarkMode),
                        SizedBox(width: 12.w),
                        _buildActionIcon(Icons.chat_bubble_rounded, isDarkMode),
                        SizedBox(width: 12.w),
                        _buildActionIcon(Icons.phone_rounded, isDarkMode),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green, size: 14.sp),
                              SizedBox(width: 6.w),
                              Text(
                                'Drop-off confirmed',
                                style: GoogleFonts.manrope(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Timeline
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimelinePoint(Icons.calendar_month_outlined, package.fromCity, "Picked up", "May 16, 09:15", isDarkMode),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
                            child: Column(
                              children: [
                                Row(
                                  children: List.generate(15, (index) => Expanded(
                                    child: Container(
                                      height: 2.h,
                                      margin: EdgeInsets.symmetric(horizontal: 1.w),
                                      color: index % 2 == 0 ? Colors.blue.withOpacity(0.5) : Colors.transparent,
                                    ),
                                  )),
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.green, size: 18.sp),
                                    SizedBox(width: 6.w),
                                    Text(
                                      'Delivered',
                                      style: GoogleFonts.manrope(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Package successfully delivered',
                                  style: GoogleFonts.manrope(
                                    fontSize: 10.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildTimelinePoint(Icons.location_on_outlined, package.toCity, "Delivered", "May 16, 16:42", isDarkMode, isEnd: true),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Proof of Delivery
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Proof of Delivery',
                  style: GoogleFonts.manrope(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  _buildProofItem("Delivered Photo", isDarkMode, imageUrl: "https://images.pexels.com/photos/4481258/pexels-photo-4481258.jpeg"),
                  SizedBox(width: 12.w),
                  _buildProofItem("Recipient QR Scan", isDarkMode, icon: Icons.qr_code_2_rounded),
                  SizedBox(width: 12.w),
                  _buildProofItem("Signature / Confirmation", isDarkMode, text: "M. Henry"),
                ],
              ),
              
              SizedBox(height: 40.h),
              
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: BorderSide(color: isDarkMode ? Colors.white12 : Colors.grey.shade200),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                      ),
                      child: Text(
                        'View Details',
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                         Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                      ),
                      child: Text(
                        'Done',
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildActionIcon(IconData icon, bool isDarkMode) {
  return Container(
    padding: EdgeInsets.all(10.r),
    decoration: BoxDecoration(
      color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
      shape: BoxShape.circle,
    ),
    child: Icon(icon, size: 18.sp, color: Colors.grey.shade600),
  );
}

Widget _buildTimelinePoint(IconData icon, String city, String status, String time, bool isDarkMode, {bool isEnd = false}) {
  return Column(
    crossAxisAlignment: isEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: const Color(0xFF4A80F0).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, size: 18.sp, color: const Color(0xFF4A80F0)),
      ),
      SizedBox(height: 8.h),
      Text(
        city,
        style: GoogleFonts.manrope(
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      Text(
        status,
        style: GoogleFonts.manrope(
          fontSize: 10.sp,
          color: Colors.grey,
        ),
      ),
      Text(
        time,
        style: GoogleFonts.manrope(
          fontSize: 10.sp,
          color: isDarkMode ? Colors.white54 : Colors.black54,
        ),
      ),
    ],
  );
}

Widget _buildProofItem(String label, bool isDarkMode, {String? imageUrl, IconData? icon, String? text}) {
  return Expanded(
    child: Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(16.r),
              image: imageUrl != null ? DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover) : null,
            ),
            child: Stack(
              children: [
                if (icon != null) Center(child: Icon(icon, size: 32.sp, color: Colors.grey)),
                if (text != null) Center(child: Text(text, style: GoogleFonts.manrope(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.grey.shade700))),
                Positioned(
                  right: 8.w,
                  bottom: 8.h,
                  child: Container(
                    padding: EdgeInsets.all(2.r),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(Icons.check_circle, color: Colors.green, size: 14.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 10.sp,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildConditionRadioTile(
  String title,
  int index,
  RxInt selectedIndex,
  bool isDarkMode,
) {
  bool isSelected = selectedIndex.value == index;
  return GestureDetector(
    onTap: () => selectedIndex.value = index,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isSelected
            ? (isDarkMode
                ? Colors.blue.withOpacity(0.05)
                : const Color(0xFFF5F8FF))
            : (isDarkMode
                ? Colors.white.withOpacity(0.03)
                : const Color(0xFFF9FAFB)),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected
              ? const Color(0xFF4A80F0)
              : (isDarkMode ? Colors.white10 : Colors.transparent),
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
                color: isSelected
                    ? const Color(0xFF4A80F0)
                    : (isDarkMode ? Colors.white24 : Colors.grey.shade300),
                width: 1.5.w,
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

Widget _buildUploadDamagePhoto(bool isDarkMode) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: isDarkMode ? Colors.white.withOpacity(0.02) : Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: isDarkMode ? Colors.white10 : Colors.grey.shade200,
        style: BorderStyle.solid,
      ),
    ),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xFF4A80F0).withOpacity(0.3),
          style: BorderStyle.none,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF4A80F0).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.camera_alt_rounded,
              color: const Color(0xFF4A80F0),
              size: 24.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Upload Damage Photo',
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4A80F0),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Photo helps document damage',
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              color: isDarkMode ? Colors.white38 : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    ),
  );
}
