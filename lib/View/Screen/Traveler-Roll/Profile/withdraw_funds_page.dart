import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/withdraw_confirmation_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/withdraw_funds_controller.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/payout_methods_page.dart';

class WithdrawFundsPage extends StatelessWidget {
  const WithdrawFundsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WithdrawFundsController controller = Get.put(WithdrawFundsController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'withdraw_funds'.tr,
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.help_outline,
              color: isDarkMode ? Colors.white : Colors.black54,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                
                // Available Balance Card
                _buildAvailableBalanceCard(controller),
                
                SizedBox(height: 24.h),
                
                // Withdraw Amount Section
                _buildWithdrawAmountSection(controller, isDarkMode),
                
                SizedBox(height: 24.h),
                
                // Select Payout Method Section
                _buildPayoutMethodSelection(controller, isDarkMode),
                
                SizedBox(height: 100.h), // Space for bottom button
              ],
            ),
          ),
          
          // Bottom Continue Button
          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const WithdrawConfirmationPage()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                minimumSize: Size(double.infinity, 56.h),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send_rounded, size: 20.sp),
                  SizedBox(width: 10.w),
                  Text(
                    'Continue',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableBalanceCard(WithdrawFundsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0066FF), Color(0xFF004FC4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0066FF).withOpacity(0.25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'available_balance'.tr,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${controller.availableBalance.toStringAsFixed(2)} TND',
                style: GoogleFonts.manrope(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 24.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawAmountSection(WithdrawFundsController controller, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'withdraw_amount'.tr,
            style: GoogleFonts.manrope(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF2C2C2E) : Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF0066FF).withOpacity(0.5)),
            ),
            child: Row(
              children: [
                Text(
                  'TND',
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black26,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: TextField(
                    controller: controller.amountController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.manrope(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      hintText: '0.00',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickOption(
                  '25%',
                  '${(controller.availableBalance * 0.25).toStringAsFixed(2)} TND',
                  isDarkMode,
                  0.25,
                  controller.selectedPercentage.value == 0.25,
                  () => controller.setAmountByPercentage(0.25),
                ),
                _buildQuickOption(
                  '50%',
                  '${(controller.availableBalance * 0.50).toStringAsFixed(2)} TND',
                  isDarkMode,
                  0.50,
                  controller.selectedPercentage.value == 0.50,
                  () => controller.setAmountByPercentage(0.50),
                ),
                _buildQuickOption(
                  '75%',
                  '${(controller.availableBalance * 0.75).toStringAsFixed(2)} TND',
                  isDarkMode,
                  0.75,
                  controller.selectedPercentage.value == 0.75,
                  () => controller.setAmountByPercentage(0.75),
                ),
                _buildQuickOption(
                  'Max',
                  '${controller.availableBalance.toStringAsFixed(2)} TND',
                  isDarkMode,
                  1.0,
                  controller.selectedPercentage.value == 1.0,
                  () => controller.setAmountByPercentage(1.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickOption(
    String label,
    String amount,
    bool isDarkMode,
    double value,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 75.w,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE8F1FF)
              : (isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF8F9FB)),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF0066FF) : Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                color: isSelected ? const Color(0xFF0066FF) : (isDarkMode ? Colors.white70 : Colors.black),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              amount,
              style: GoogleFonts.manrope(
                fontSize: 8.sp,
                color: isSelected ? const Color(0xFF0066FF).withOpacity(0.6) : Colors.black26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayoutMethodSelection(WithdrawFundsController controller, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'select_payout_method'.tr,
          style: GoogleFonts.manrope(
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
                title: 'Bank Account',
                subtitle: '•••• 8825',
                icon: Icons.account_balance_outlined,
                isDarkMode: isDarkMode,
                isSelected: controller.selectedMethodIndex.value == 0,
                onTap: () => controller.selectMethod(0),
                hasTag: true,
              ),
              SizedBox(height: 12.h),
              _buildMethodTile(
                title: 'PayPal',
                subtitle: 'steven@example.com',
                svgIcon: AppIcons.payPal,
                isDarkMode: isDarkMode,
                isSelected: controller.selectedMethodIndex.value == 1,
                onTap: () => controller.selectMethod(1),
              ),
              SizedBox(height: 12.h),
              _buildMethodTile(
                title: 'Google Pay',
                subtitle: 'steven@example.com',
                svgIcon: AppIcons.googlePay,
                isDarkMode: isDarkMode,
                isSelected: controller.selectedMethodIndex.value == 2,
                onTap: () => controller.selectMethod(2),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        OutlinedButton(
          onPressed: () => Get.to(() => const PayoutMethodsPage()),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: const Color(0xFF0066FF).withOpacity(0.3)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            minimumSize: Size(double.infinity, 50.h),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline, color: const Color(0xFF0066FF), size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Add payout method',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: const Color(0xFF0066FF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMethodTile({
    required String title,
    required String subtitle,
    IconData? icon,
    String? svgIcon,
    required bool isDarkMode,
    required bool isSelected,
    required VoidCallback onTap,
    bool hasTag = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF0066FF) : (isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1FF),
                shape: BoxShape.circle,
              ),
              child: svgIcon != null
                  ? SvgPicture.asset(svgIcon, width: 24.sp, height: 24.sp)
                  : Icon(icon, color: const Color(0xFF0066FF), size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.manrope(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      if (hasTag) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Primary',
                            style: GoogleFonts.manrope(
                              fontSize: 10.sp,
                              color: const Color(0xFF2E7D32),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      color: Colors.black26,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF0066FF) : Colors.black12,
                  width: 1,
                ),
                color: isSelected ? const Color(0xFF0066FF) : Colors.transparent,
              ),
              child: isSelected ? Icon(Icons.check, color: Colors.white, size: 14.sp) : null,
            ),
          ],
        ),
      ),
    );
  }
}
