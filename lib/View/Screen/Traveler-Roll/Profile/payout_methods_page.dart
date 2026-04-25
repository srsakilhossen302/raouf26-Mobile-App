import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/add_bank_account_page.dart';

class PayoutMethodsPage extends StatelessWidget {
  const PayoutMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Payout Methods',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                
                // Info Section
                Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.black26, size: 20.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Choose where your withdrawals are sent.',
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 24.h),
                
                // Payout Methods List
                _buildMethodCard(
                  isDarkMode: isDarkMode,
                  title: 'Bank Account',
                  subtitle: '•••• 8825',
                  tagText: 'Primary',
                  tagColor: const Color(0xFF2E7D32),
                  tagBgColor: const Color(0xFFE8F5E9),
                  icon: Icons.account_balance_outlined,
                  onTap: () {},
                ),
                
                SizedBox(height: 16.h),
                
                _buildMethodCard(
                  isDarkMode: isDarkMode,
                  title: 'PayPal',
                  subtitle: '•••@gmail.com',
                  tagText: 'Verified',
                  tagColor: const Color(0xFF0066FF),
                  tagBgColor: const Color(0xFFE8F1FF),
                  svgIcon: AppIcons.payPal,
                  onTap: () {},
                ),
                
                SizedBox(height: 16.h),
                
                _buildMethodCard(
                  isDarkMode: isDarkMode,
                  title: 'Google Pay',
                  subtitle: '•••• 3456',
                  tagText: 'Verified',
                  tagColor: const Color(0xFF2E7D32),
                  tagBgColor: const Color(0xFFE8F5E9),
                  svgIcon: AppIcons.googlePay,
                  onTap: () {},
                ),
                
                SizedBox(height: 16.h),
                
                _buildMethodCard(
                  isDarkMode: isDarkMode,
                  title: 'Stripe',
                  subtitle: 'acct_••••••••1234',
                  tagText: 'Not Set',
                  tagColor: const Color(0xFF757575),
                  tagBgColor: const Color(0xFFF5F5F5),
                  icon: Icons.credit_card_outlined,
                  onTap: () {},
                ),
                
                SizedBox(height: 24.h),
                
                // Set Primary Button
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: const Color(0xFF0066FF).withOpacity(0.3)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    minimumSize: Size(double.infinity, 50.h),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings_outlined, color: const Color(0xFF0066FF), size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Set primary payout method',
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          color: const Color(0xFF0066FF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 100.h), // Space for bottom button
              ],
            ),
          ),
          
          // Add New Method Button
          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const AddBankAccountPage()),
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
                  Icon(Icons.add_circle_outline, size: 20.sp),
                  SizedBox(width: 10.w),
                  Text(
                    'Add New Method',
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

  Widget _buildMethodCard({
    required bool isDarkMode,
    required String title,
    required String subtitle,
    required String tagText,
    required Color tagColor,
    required Color tagBgColor,
    IconData? icon,
    String? svgIcon,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF2C2C2E) : const Color(0xFFE8F1FF),
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
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      color: isDarkMode ? Colors.white38 : Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isDarkMode ? tagBgColor.withOpacity(0.1) : tagBgColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                tagText,
                style: GoogleFonts.manrope(
                  fontSize: 11.sp,
                  color: isDarkMode ? tagColor.withOpacity(0.9) : tagColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Icon(Icons.chevron_right, color: isDarkMode ? Colors.white24 : Colors.black26, size: 24.sp),
          ],
        ),
      ),
    );
  }

}
