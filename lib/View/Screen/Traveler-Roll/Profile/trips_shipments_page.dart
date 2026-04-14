import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/transaction_history_page.dart';

class TripsShipmentsPage extends StatelessWidget {
  const TripsShipmentsPage({super.key});

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
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'trips_shipments'.tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline_rounded, color: isDarkMode ? Colors.white : Colors.black),
            onPressed: () => _showAboutBottomSheet(context, isDarkMode),
          ),
          IconButton(
            icon: Icon(Icons.download_outlined, color: isDarkMode ? Colors.white : Colors.black),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            
            // Transaction History Card
            _buildTransactionHistoryCard(isDarkMode),
            
            SizedBox(height: 24.h),
            
            // Sent Packages Section
            _buildSectionTitle('sent_packages'.tr, isDarkMode),
            SizedBox(height: 12.h),
            _buildPackageItem(
              title: "Package to Paris",
              subtitle: "2 Nov, 9:30 AM",
              status: "delivered",
              amount: "€45.00",
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 12.h),
            _buildPackageItem(
              title: "Package to Paris",
              subtitle: "2 Nov, 9:30 AM",
              status: "cancelled",
              amount: "€0.00",
              isDarkMode: isDarkMode,
            ),
            
            SizedBox(height: 24.h),
            
            // Delivered Packages Section
            _buildSectionTitle('delivered_packages'.tr, isDarkMode),
            SizedBox(height: 12.h),
            _buildPackageItem(
              title: "Package to Paris",
              subtitle: "2 Nov, 9:30 AM",
              status: "delivered",
              amount: "€45.00",
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionHistoryCard(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: ListTile(
        onTap: () => Get.to(() => const TransactionHistoryPage()),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        leading: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.history_rounded,
            color: isDarkMode ? Colors.white70 : Colors.black87,
            size: 20.sp,
          ),
        ),
        title: Text(
          'transaction_history'.tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 20.sp,
          color: isDarkMode ? Colors.white38 : Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildPackageItem({
    required String title,
    required String subtitle,
    required String status,
    required String amount,
    required bool isDarkMode,
  }) {
    Color statusColor;
    String statusLabel;
    
    switch (status.toLowerCase()) {
      case 'delivered':
        statusColor = Colors.green;
        statusLabel = 'delivered'.tr;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusLabel = 'cancelled'.tr;
        break;
      default:
        statusColor = Colors.orange;
        statusLabel = 'pending'.tr;
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text(
                    subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    " • ",
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                  Text(
                    statusLabel,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            amount,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutBottomSheet(BuildContext context, bool isDarkMode) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'About Trips & Shipments',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, color: isDarkMode ? Colors.white : Colors.black),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            _buildAboutItem(
              icon: Icons.history_rounded,
              title: "Transaction History",
              desc: "View all payments, earnings, and completed transactions related to your trips and shipments.",
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 20.h),
            _buildAboutItem(
              icon: Icons.inventory_2_outlined,
              title: "Sent Packages",
              desc: "Packages you've requested to send through travelers. You can track their status here (Delivered, Cancelled, Pending).",
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 20.h),
            _buildAboutItem(
              icon: Icons.check_circle_outline_rounded,
              title: "Delivered Packages",
              desc: "Packages you've successfully delivered or received, including payment details.",
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 32.h),
            Text(
              "Status Colors",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF8F9FB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildStatusLegend(Colors.green, "Successfully completed"),
                  SizedBox(height: 8.h),
                  _buildStatusLegend(Colors.orange, "Pending— Waiting for confirmation"),
                  SizedBox(height: 8.h),
                  _buildStatusLegend(Colors.red, "Cancelled— Request was cancelled"),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildAboutItem({
    required IconData icon,
    required String title,
    required String desc,
    required bool isDarkMode,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: isDarkMode ? Colors.white70 : Colors.black87, size: 20.sp),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                desc,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusLegend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 12.w),
        Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
