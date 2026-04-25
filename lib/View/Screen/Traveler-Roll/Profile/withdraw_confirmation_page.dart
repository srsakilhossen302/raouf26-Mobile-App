import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/withdraw_success_page.dart';

class WithdrawConfirmationPage extends StatelessWidget {
  const WithdrawConfirmationPage({super.key});

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
          'Review Withdrawal',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            
            // Withdrawal Summary Card
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Withdrawal Summary',
                    style: GoogleFonts.manrope(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  
                  _buildReviewItem(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Amount',
                    value: '600.00 TND',
                    isDarkMode: isDarkMode,
                  ),
                  _buildReviewItem(
                    icon: Icons.account_balance_outlined,
                    label: 'Payout Method',
                    value: 'Bank Account ending 8825',
                    isDarkMode: isDarkMode,
                    hasTag: true,
                  ),
                  _buildReviewItem(
                    icon: Icons.access_time,
                    label: 'Estimated Arrival',
                    value: '1–2 business days',
                    isDarkMode: isDarkMode,
                  ),
                  _buildReviewItem(
                    icon: Icons.percent_outlined,
                    label: 'Fee',
                    value: '0.00 TND',
                    isDarkMode: isDarkMode,
                  ),
                  
                  const Divider(height: 32),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F1FF),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.account_balance_wallet_outlined, color: const Color(0xFF0066FF), size: 20.sp),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Total to Receive',
                            style: GoogleFonts.manrope(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '600.00 TND',
                        style: GoogleFonts.manrope(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Info Banner
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1FF).withOpacity(0.5),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: const Color(0xFF0066FF), size: 20.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'You can track this payout in Recent Transactions.',
                      style: GoogleFonts.manrope(
                        fontSize: 13.sp,
                        color: const Color(0xFF0066FF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            // Back Button
            OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: const Color(0xFF0066FF).withOpacity(0.3)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                minimumSize: Size(double.infinity, 56.h),
              ),
              child: Text(
                'Back',
                style: GoogleFonts.manrope(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0066FF),
                ),
              ),
            ),
            
            SizedBox(height: 12.h),
            
            // Confirm Button
            ElevatedButton(
              onPressed: () => Get.to(() => const WithdrawSuccessPage()),
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
                    'Confirm Withdrawal',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem({
    required IconData icon,
    required String label,
    required String value,
    required bool isDarkMode,
    bool hasTag = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF2C2C2E) : const Color(0xFFF8F9FB),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: isDarkMode ? Colors.white38 : Colors.black26, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.manrope(
                    fontSize: 13.sp,
                    color: isDarkMode ? Colors.white38 : Colors.black45,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
