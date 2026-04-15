import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/DeliveryInfo/delivery_info_controller.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/ReviewDelivery/review_delivery_view.dart';
import 'package:raouf26mobileapp/utils/appicons/app_icons.dart';

class DeliveryInfoView extends GetView<DeliveryInfoController> {
  const DeliveryInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DeliveryInfoController());
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
            child: Container(
              width: 1.sw, // Full progress for the 3 steps
              color: const Color(0xFF4A80F0),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery Information",
              style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Enter recipient details and choose delivery options.",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24.h),

            // Who Are You Sending to? Section
            _sectionTitle("Who Are You Sending to?", isDarkMode),
            SizedBox(height: 16.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _inviteNewCircle(isDarkMode),
                  SizedBox(width: 20.w),
                  ...controller.contacts.map(
                    (contact) => Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: _contactCircle(
                        contact['name']!,
                        contact['image']!,
                        isDarkMode,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Recipient's Name Field
            _sectionTitle("Recipient's Name", isDarkMode),
            SizedBox(height: 12.h),
            _customTextField(
              controller: controller.recipientNameController,
              hintText: "Enter Recipient's Name",
              suffixIcon: AppIcons.partion,
              isDarkMode: isDarkMode,
            ),

            SizedBox(height: 20.h),

            // Phone Number Field
            _sectionTitle("Phone Number", isDarkMode),
            SizedBox(height: 12.h),
            _phoneTextField(isDarkMode),

            SizedBox(height: 24.h),

            // Map Section
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  // Mock Map Container
                  Container(
                    height: 160.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.r),
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://static-maps.yandex.ru/1.x/?lang=en_US&ll=10.6346,35.8256&z=13&l=map&size=450,450",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.adjustLocation(),
                        icon: const Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Adjust Location",
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Address Bar
                  Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Obx(
                            () => Text(
                              controller.selectedAddress.value,
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          AppIcons.save,
                          width: 20.w,
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Pickup Method
            _sectionTitle("Pickup Method", isDarkMode),
            SizedBox(height: 8.h),
            Text(
              "How should the package be collected?",
              style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.h),
            Obx(
              () => Column(
                children: [
                   Row(
                    children: [
                      Expanded(
                        child: _selectionChip(
                          label: controller.pickupMethodOptions[0],
                          isSelected: controller.selectedPickupMethod.value == controller.pickupMethodOptions[0],
                          onTap: () => controller.setPickupMethod(controller.pickupMethodOptions[0]),
                          isDarkMode: isDarkMode,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _selectionChip(
                          label: controller.pickupMethodOptions[1],
                          isSelected: controller.selectedPickupMethod.value == controller.pickupMethodOptions[1],
                          onTap: () => controller.setPickupMethod(controller.pickupMethodOptions[1]),
                          isDarkMode: isDarkMode,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                   Row(
                    children: [
                      Expanded(
                        child: _selectionChip(
                          label: controller.pickupMethodOptions[2],
                          isSelected: controller.selectedPickupMethod.value == controller.pickupMethodOptions[2],
                          onTap: () => controller.setPickupMethod(controller.pickupMethodOptions[2]),
                          isDarkMode: isDarkMode,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Delivery Method
            _sectionTitle("Delivery Method", isDarkMode),
            SizedBox(height: 8.h),
            Text(
              "How should the package reach the receiver?",
              style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.h),
            Obx(
              () => Column(
                children: [
                   Row(
                    children: [
                      Expanded(
                        child: _selectionChip(
                          label: controller.deliveryMethodOptions[0],
                          isSelected: controller.selectedDeliveryMethod.value == controller.deliveryMethodOptions[0],
                          onTap: () => controller.setDeliveryMethod(controller.deliveryMethodOptions[0]),
                          isDarkMode: isDarkMode,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _selectionChip(
                          label: controller.deliveryMethodOptions[1],
                          isSelected: controller.selectedDeliveryMethod.value == controller.deliveryMethodOptions[1],
                          onTap: () => controller.setDeliveryMethod(controller.deliveryMethodOptions[1]),
                          isDarkMode: isDarkMode,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                   Row(
                    children: [
                      Expanded(
                        child: _selectionChip(
                          label: controller.deliveryMethodOptions[2],
                          isSelected: controller.selectedDeliveryMethod.value == controller.deliveryMethodOptions[2],
                          onTap: () => controller.setDeliveryMethod(controller.deliveryMethodOptions[2]),
                          isDarkMode: isDarkMode,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Main Continue Button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const ReviewDeliveryView()),
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
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _inviteNewCircle(bool isDarkMode) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              AppIcons.inviteNew,
              width: 24.w,
              height: 24.h,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Invite New",
          style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _contactCircle(String name, String imageUrl, bool isDarkMode) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          name,
          style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _selectionChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100)
              : (isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50),
          borderRadius: BorderRadius.circular(12.r),
          border: isSelected
              ? Border.all(color: const Color(0xFF4A80F0).withOpacity(0.5))
              : null,
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? const Color(0xFF4A80F0) : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    required TextEditingController controller,
    required String hintText,
    String? suffixIcon,
    required bool isDarkMode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.montserrat(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.montserrat(
            color: Colors.grey,
            fontSize: 14.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: EdgeInsets.all(12.r),
                  child: SvgPicture.asset(
                    suffixIcon,
                    width: 20.w,
                    height: 20.h,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _phoneTextField(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2.r),
                  child: Image.asset(
                    "assets/images/image.png",
                    width: 24.w,
                    height: 16.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "+216",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(width: 1.w, height: 24.h, color: Colors.grey.shade300),
          Expanded(
            child: TextField(
              controller: controller.phoneNumberController,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.montserrat(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "00000000",
                hintStyle: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
