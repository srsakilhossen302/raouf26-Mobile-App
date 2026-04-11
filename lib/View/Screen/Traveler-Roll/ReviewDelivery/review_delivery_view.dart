import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/ReviewDelivery/review_delivery_controller.dart';
import 'package:raouf26mobileapp/utils/appicons/app_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewDeliveryView extends GetView<ReviewDeliveryController> {
  const ReviewDeliveryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReviewDeliveryController());
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Review Delivery Details",
              style: GoogleFonts.montserrat(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Please review your information before finding a transporter.",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24.h),

            // Package Details Section
            _reviewSection(
              title: "Package Details",
              isDarkMode: isDarkMode,
              onEdit: () => controller.editSection("Package"),
              children: [
                _reviewRow("Package Size", controller.packageSize.value),
                _reviewRow("Exact Weight", controller.exactWeight.value),
                _reviewRow(
                  "Package Category",
                  controller.packageCategory.value,
                ),
                _reviewRow("Package Size", controller.packageItems.value),
                _reviewPhotosRow(),
                _reviewRow(
                  "Storage Period",
                  controller.storagePeriod.value,
                  color: const Color(0xFF4A80F0),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    controller.storageDays.value,
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Sender Details Section
            _reviewSection(
              title: "Sender Details",
              isDarkMode: isDarkMode,
              onEdit: () => controller.editSection("Sender"),
              children: [
                _reviewRow("Sender name", controller.senderName.value),
                _reviewRow("Phone number", controller.senderPhone.value),
                _reviewRow("Pickup address", controller.pickupAddress.value),
              ],
            ),

            SizedBox(height: 16.h),

            // Delivery Details Section
            _reviewSection(
              title: "Delivery Details",
              isDarkMode: isDarkMode,
              onEdit: () => controller.editSection("Delivery"),
              children: [
                _reviewRow("Recipient name", controller.recipientName.value),
                _reviewRow("Phone number", controller.recipientPhone.value),
                _reviewRow(
                  "Delivery address",
                  controller.deliveryAddress.value,
                ),
                _reviewRow(
                  "Delivery speed",
                  controller.deliverySpeed.value,
                  color: Colors.red,
                ),
                _reviewRow(
                  "Delivery Preference",
                  controller.deliveryPreference.value,
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Delivery Route Section
            _reviewSection(
              title: "Delivery Route",
              isDarkMode: isDarkMode,
              showEdit: false,
              children: [
                Container(
                  height: 140.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://static-maps.yandex.ru/1.x/?lang=en_US&ll=10.4000,36.3000&z=9&l=map&size=450,450",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                _routeRow(
                  Icons.near_me_outlined,
                  "Pickup: ${controller.pickupAddress.value}",
                ),
                SizedBox(height: 12.h),
                _routeRow(
                  Icons.location_on_outlined,
                  "Delivery: ${controller.deliveryAddress.value}",
                ),
                const Divider(),
                _reviewRow(
                  "Estimated Distance",
                  controller.estimatedDistance.value,
                  isBold: true,
                ),
              ],
            ),

            SizedBox(height: 32.h),

            // Find Transporter Button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () => controller.findTransporter(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Find Transporter",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _reviewSection({
    required String title,
    required bool isDarkMode,
    required List<Widget> children,
    VoidCallback? onEdit,
    bool showEdit = true,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              if (showEdit)
                GestureDetector(
                  onTap: onEdit,
                  child: SvgPicture.asset(
                    AppIcons.edit,
                    width: 24.w,
                    height: 24.h,
                    colorFilter: ColorFilter.mode(
                      Colors.grey.shade600,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          ...children,
        ],
      ),
    );
  }

  Widget _reviewRow(
    String label,
    String value, {
    Color? color,
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 13.sp,
              color: Colors.grey.shade600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
                color: color ?? (Get.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewPhotosRow() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Package Photos",
            style: GoogleFonts.montserrat(
              fontSize: 13.sp,
              color: Colors.grey.shade600,
            ),
          ),
          Row(
            children: [
              _photoThumbnail(
                "https://images.unsplash.com/photo-1580915411954-282cb1b0d780?q=80&w=100&auto=format&fit=crop",
              ),
              SizedBox(width: 8.w),
              _photoThumbnail(
                "https://images.unsplash.com/photo-1566576721346-d4a3b4eaad5b?q=80&w=100&auto=format&fit=crop",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _photoThumbnail(String url) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }

  Widget _routeRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 20.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 13.sp,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
