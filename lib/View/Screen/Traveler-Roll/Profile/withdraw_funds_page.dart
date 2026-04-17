import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/withdraw_confirmation_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/withdraw_funds_controller.dart';

class WithdrawFundsPage extends StatelessWidget {
  const WithdrawFundsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WithdrawFundsController controller = Get.put(
      WithdrawFundsController(),
    );
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FB),
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
        centerTitle: true,
        title: Text(
          'withdraw_funds'.tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // Available Balance Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFF4A80F0),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Text(
                    'available_balance'.tr,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2.r),
                        child: Image.asset(
                          "assets/images/image.png",
                          width: 32.w,
                          height: 20.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${controller.availableBalance.toStringAsFixed(2)} TND',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Amount Input
            Text(
              'withdraw_amount'.tr,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: controller.amountController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: '0.00',
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
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
                    SizedBox(width: 4.w),
                    Text(
                      'TND',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
                filled: true,
                fillColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Quick Options
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickOption(
                    '25%',
                    isDarkMode,
                    0.25,
                    controller.selectedPercentage.value == 0.25,
                    () => controller.setAmountByPercentage(0.25),
                  ),
                  _buildQuickOption(
                    '50%',
                    isDarkMode,
                    0.50,
                    controller.selectedPercentage.value == 0.50,
                    () => controller.setAmountByPercentage(0.50),
                  ),
                  _buildQuickOption(
                    '75%',
                    isDarkMode,
                    0.75,
                    controller.selectedPercentage.value == 0.75,
                    () => controller.setAmountByPercentage(0.75),
                  ),
                  _buildQuickOption(
                    'Max',
                    isDarkMode,
                    1.0,
                    controller.selectedPercentage.value == 1.0,
                    () => controller.setAmountByPercentage(1.0),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Payout Method Selection
            Text(
              'select_payout_method'.tr,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),

            Obx(
              () => Column(
                children: [
                  _buildMethodTile(
                    'Bank Account',
                    '**** 8823',
                    Icons.account_balance,
                    isDarkMode,
                    0,
                    controller.selectedMethodIndex.value == 0,
                    () => controller.selectMethod(0),
                  ),
                  SizedBox(height: 12.h),
                  _buildMethodTile(
                    'PayPal',
                    'john.doe@email.com',
                    AppIcons.payPal,
                    isDarkMode,
                    1,
                    controller.selectedMethodIndex.value == 1,
                    () => controller.selectMethod(1),
                  ),
                  SizedBox(height: 12.h),
                  _buildMethodTile(
                    'Google Pay',
                    'john.doe@gmail.com',
                    AppIcons.googlePay,
                    isDarkMode,
                    2,
                    controller.selectedMethodIndex.value == 2,
                    () => controller.selectMethod(2),
                  ),
                  SizedBox(height: 12.h),
                  _buildMethodTile(
                    'Stripe',
                    'stripe_acc_123...',
                    AppIcons.visaCard,
                    isDarkMode,
                    3,
                    controller.selectedMethodIndex.value == 3,
                    () => controller.selectMethod(3),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const WithdrawConfirmationPage()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'withdraw_now'.tr,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickOption(
    String label,
    bool isDarkMode,
    double value,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4A80F0)
              : (isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4A80F0)
                : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Colors.white
                : (isDarkMode ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildMethodTile(
    String title,
    String subtitle,
    dynamic icon,
    bool isDarkMode,
    int index,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4A80F0)
                : Colors.grey.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            if (icon is IconData)
              Icon(
                icon,
                color: isSelected ? const Color(0xFF4A80F0) : Colors.grey,
              )
            else if (icon is String)
              SvgPicture.asset(icon, width: 32.w, fit: BoxFit.contain),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: const Color(0xFF4A80F0),
            ),
          ],
        ),
      ),
    );
  }
}
