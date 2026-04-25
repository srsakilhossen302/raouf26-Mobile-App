import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class WithdrawSuccessPage extends StatelessWidget {
  const WithdrawSuccessPage({super.key});

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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            // Withdrawal Complete Card with Illustration
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
              ),
              child: Column(
                children: [
                  // Custom Illustration using Stack
                  _buildSuccessIllustration(),
                  
                  SizedBox(height: 32.h),
                  
                  Text(
                    '600.00 TND is on the way',
                    style: GoogleFonts.manrope(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0D1B3E),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Your withdrawal has been submitted successfully.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      color: const Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Transaction Details Card
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
              ),
              child: Column(
                children: [
                  _buildDetailItem(
                    icon: Icons.account_balance_outlined,
                    label: 'Payout Destination',
                    value: 'Bank Account •••• 8825',
                    isDarkMode: isDarkMode,
                    hasTag: true,
                  ),
                  _buildDetailItem(
                    icon: Icons.calendar_today_outlined,
                    label: 'Submitted',
                    value: 'May 21, 2025 at 10:24 AM',
                    isDarkMode: isDarkMode,
                  ),
                  _buildDetailItem(
                    icon: Icons.access_time,
                    label: 'Estimated Arrival',
                    value: '1–2 business days',
                    isDarkMode: isDarkMode,
                    trailingIcon: Icons.info_outline,
                  ),
                  _buildDetailItem(
                    icon: Icons.label_outline,
                    label: 'Reference ID',
                    value: 'WD-28491',
                    isDarkMode: isDarkMode,
                    trailingIcon: Icons.copy_outlined,
                    isLast: true,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 40.h),
            
            // View Transaction Button
            ElevatedButton(
              onPressed: () => Get.back(),
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
                  Icon(Icons.bar_chart_rounded, size: 20.sp),
                  SizedBox(width: 10.w),
                  Text(
                    'View Transaction',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 12.h),
            
            // Back to Balance Button
            OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: const Color(0xFF0066FF).withOpacity(0.3)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                minimumSize: Size(double.infinity, 56.h),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, size: 20.sp, color: const Color(0xFF0066FF)),
                  SizedBox(width: 10.w),
                  Text(
                    'Back to Balance',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0066FF),
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

  Widget _buildSuccessIllustration() {
    return Image.asset(
      'assets/images/img.png',
      height: 180.h,
      width: double.infinity,
      fit: BoxFit.contain,
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required bool isDarkMode,
    IconData? trailingIcon,
    bool hasTag = false,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF2C2C2E) : const Color(0xFFF3F6FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isDarkMode ? Colors.white38 : const Color(0xFF0066FF).withOpacity(0.7),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: const Color(0xFF757575),
                    fontWeight: FontWeight.w500,
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
                          color: isDarkMode ? Colors.white : const Color(0xFF0D1B3E),
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
                    if (trailingIcon != null) ...[
                      SizedBox(width: 8.w),
                      Icon(trailingIcon, color: const Color(0xFF757575).withOpacity(0.5), size: 18.sp),
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
