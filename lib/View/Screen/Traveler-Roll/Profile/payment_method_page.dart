import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/add_payment_method_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/add_bank_account_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/withdraw_funds_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/transaction_history_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/payout_methods_page.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

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
          'Balance & Payments',
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
                _buildAvailableBalanceCard(),
                
                SizedBox(height: 20.h),
                
                // Stats Grid (2x2)
                _buildStatsGrid(isDarkMode),
                
                SizedBox(height: 24.h),
                
                // Payout Method Section
                _buildPayoutMethodSection(isDarkMode),
                
                SizedBox(height: 24.h),
                
                // Recent Transactions Section
                _buildRecentTransactionsSection(isDarkMode),
                
                SizedBox(height: 100.h), // Padding for floating button
              ],
            ),
          ),
          
          // Floating Bottom Button
          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: _buildWithdrawButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableBalanceCard() {
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
                '2,450.00 TND',
                style: GoogleFonts.manrope(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 24.sp),
                  ),
                  SizedBox(width: 12.w),
                  Icon(Icons.chevron_right, color: Colors.white, size: 24.sp),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF34C759),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'Ready to withdraw',
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'pending_earnings'.tr + ': 450.00 TND',
                style: GoogleFonts.manrope(
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () => Get.to(() => const AddPaymentMethodPage()),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        'deposit_methods'.tr,
                        style: GoogleFonts.manrope(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(bool isDarkMode) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 16.h,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          isDarkMode: isDarkMode,
          title: 'Pending Balance',
          value: '450.00 TND',
          subtext: 'Processing',
          icon: Icons.access_time_rounded,
          iconColor: const Color(0xFFFF9500),
        ),
        _buildStatCard(
          isDarkMode: isDarkMode,
          title: 'Paid Out This Month',
          value: '3,860.00 TND',
          subtext: '12 payouts',
          icon: Icons.trending_up_rounded,
          iconColor: const Color(0xFF34C759),
        ),
        _buildStatCard(
          isDarkMode: isDarkMode,
          title: 'Upcoming Earnings',
          value: '890.00 TND',
          subtext: 'From scheduled deliveries',
          icon: Icons.bar_chart_rounded,
          iconColor: const Color(0xFF007AFF),
        ),
        _buildStatCard(
          isDarkMode: isDarkMode,
          title: 'Next Payout Date',
          value: 'May 28, 2025',
          subtext: 'In 3 days',
          icon: Icons.calendar_today_outlined,
          iconColor: const Color(0xFF5856D6),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required bool isDarkMode,
    required String title,
    required String value,
    required String subtext,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 18.sp),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 10.sp,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                subtext,
                style: GoogleFonts.manrope(
                  fontSize: 9.sp,
                  color: title == 'Pending Balance' ? const Color(0xFFFF9500) : (isDarkMode ? Colors.white38 : Colors.black45),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayoutMethodSection(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'payout_methods'.tr,
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.account_balance_outlined, color: const Color(0xFF0066FF), size: 24.sp),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'bank_account'.tr,
                      style: GoogleFonts.manrope(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      '•••• 8825',
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
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Primary',
                  style: GoogleFonts.manrope(
                    fontSize: 11.sp,
                    color: const Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Icon(Icons.chevron_right, color: isDarkMode ? Colors.white24 : Colors.black26, size: 24.sp),
            ],
          ),
        ),
        SizedBox(height: 12.h),
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
                'Add or change payout method',
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

  Widget _buildRecentTransactionsSection(bool isDarkMode) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'transaction_history'.tr,
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            TextButton(
              onPressed: () => Get.to(() => const TransactionHistoryPage()),
              child: Text(
                'see_all'.tr,
                style: GoogleFonts.manrope(
                  fontSize: 13.sp,
                  color: const Color(0xFF0066FF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
          ),
          child: Column(
            children: [
              _buildTransactionItem(
                isDarkMode: isDarkMode,
                title: 'Payout',
                info: 'May 20, 2025  •  Bank Account',
                amount: '+2,450.00 TND',
                isPositive: true,
                icon: Icons.arrow_downward_rounded,
                iconColor: const Color(0xFF34C759),
              ),
              Divider(height: 1, color: isDarkMode ? Colors.white10 : const Color(0xFFF5F5F5)),
              _buildTransactionItem(
                isDarkMode: isDarkMode,
                title: 'Delivery Earnings',
                info: 'May 19, 2025',
                amount: '+620.00 TND',
                isPositive: true,
                icon: Icons.arrow_upward_rounded,
                iconColor: const Color(0xFF007AFF),
              ),
              Divider(height: 1, color: isDarkMode ? Colors.white10 : const Color(0xFFF5F5F5)),
              _buildTransactionItem(
                isDarkMode: isDarkMode,
                title: 'Service Fee',
                info: 'May 19, 2025',
                amount: '-18.60 TND',
                isPositive: false,
                icon: Icons.percent_rounded,
                iconColor: const Color(0xFFFF9500),
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem({
    required bool isDarkMode,
    required String title,
    required String info,
    required String amount,
    required bool isPositive,
    required IconData icon,
    required Color iconColor,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  info,
                  style: GoogleFonts.manrope(
                    fontSize: 11.sp,
                    color: isDarkMode ? Colors.white38 : Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                amount,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: isPositive ? const Color(0xFF34C759) : const Color(0xFFFF3B30),
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.chevron_right, color: isDarkMode ? Colors.white24 : Colors.black26, size: 18.sp),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildWithdrawButton() {
    return ElevatedButton(
      onPressed: () => Get.to(() => const WithdrawFundsPage()),
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
            'withdraw_funds'.tr,
            style: GoogleFonts.manrope(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
