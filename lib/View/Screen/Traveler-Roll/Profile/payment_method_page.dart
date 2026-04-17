import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/add_payment_method_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/add_bank_account_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/withdraw_funds_page.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          'payments_wallet'.tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // Available Balance Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A80F0), Color(0xFF1A56DB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A80F0).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
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
                        '2,450.00 TND',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'pending_earnings'.tr + ': 450.00 TND',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const WithdrawFundsPage()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF4A80F0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text(
                        'withdraw_funds'.tr,
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Deposit Methods
            _buildSectionTitle('deposit_methods'.tr, isDarkMode),
            SizedBox(height: 12.h),
            _buildSectionCard(
              isDarkMode: isDarkMode,
              items: [
                _buildPaymentItem(
                  'credit_debit_card'.tr,
                  AppIcons.creditDebitCard,
                  isDarkMode,
                  onTap: () => Get.to(() => const AddPaymentMethodPage()),
                ),
                _buildPaymentItem(
                  'stripe'.tr,
                  AppIcons.visaCard,
                  isDarkMode,
                  onTap: () {},
                ),
                _buildPaymentItem(
                  'apple_pay'.tr,
                  AppIcons.applePay,
                  isDarkMode,
                  onTap: () {},
                ),
                _buildPaymentItem(
                  'google_pay'.tr,
                  AppIcons.googlePay,
                  isDarkMode,
                  onTap: () {},
                ),
                _buildPaymentItem(
                  'tn_marketplace'.tr,
                  "assets/images/image.png",
                  isDarkMode,
                  onTap: () {},
                  isLast: true,
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Payout Methods
            _buildSectionTitle('payout_methods'.tr, isDarkMode),
            SizedBox(height: 12.h),
            _buildSectionCard(
              isDarkMode: isDarkMode,
              items: [
                _buildPaymentItem(
                  'bank_account'.tr,
                  AppIcons.sentitCredits, // Fallback icon
                  isDarkMode,
                  onTap: () => Get.to(() => const AddBankAccountPage()),
                ),
                _buildPaymentItem(
                  'paypal'.tr,
                  AppIcons.payPal,
                  isDarkMode,
                  onTap: () {},
                  isLast: true,
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required List<Widget> items,
    required bool isDarkMode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildPaymentItem(
    String title,
    String iconPath,
    bool isDarkMode, {
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    bool isImage = iconPath.endsWith('.png') || iconPath.endsWith('.jpg');
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            width: 48.w,
            height: 32.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: isDarkMode
                    ? Colors.white10
                    : Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: isImage
                ? Image.asset(iconPath, fit: BoxFit.contain)
                : SvgPicture.asset(iconPath, fit: BoxFit.contain),
          ),
          title: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            size: 18.sp,
            color: isDarkMode ? Colors.white38 : Colors.grey[400],
          ),
        ),
        if (!isLast)
          Divider(
            indent: 56.w,
            endIndent: 16.w,
            height: 1,
            color: isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.1),
          ),
      ],
    );
  }
}
