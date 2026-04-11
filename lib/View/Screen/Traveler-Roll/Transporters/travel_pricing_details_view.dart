import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Transporters/transporters_controller.dart';
import '../../../../Utils/AppIcons/app_icons.dart';

class TravelPricingDetailsView extends StatelessWidget {
  final Transporter transporter;
  const TravelPricingDetailsView({super.key, required this.transporter});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Conversation Details",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Profile Card
            _buildSectionCard(
              isDarkMode,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: NetworkImage(transporter.imageUrl),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          transporter.name,
                          style: GoogleFonts.montserrat(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        SvgPicture.asset(AppIcons.verifa, width: 14.w, height: 14.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            _sectionTitle("Travel Information", isDarkMode),
            _buildSectionCard(
              isDarkMode,
              child: Column(
                children: [
                  _infoRow(
                    isDarkMode,
                    icon: AppIcons.route,
                    label: "Route",
                    value: "${transporter.from} → ${transporter.to}",
                  ),
                  _divider(),
                  _infoRow(
                    isDarkMode,
                    icon: AppIcons.departure,
                    label: "Departure",
                    value: transporter.fromDate,
                  ),
                  _divider(),
                  _infoRow(
                    isDarkMode,
                    icon: AppIcons.date,
                    label: "Return",
                    value: transporter.toDate,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            _sectionTitle("Pricing", isDarkMode),
            _buildSectionCard(
              isDarkMode,
              child: Column(
                children: [
                  _pricingRow(isDarkMode, label: "Price Per kg", value: transporter.pricePerKg),
                  SizedBox(height: 16.h),
                  _pricingRow(isDarkMode, label: "Package Weight", value: "15 kg"),
                  SizedBox(height: 16.h),
                  _pricingRow(isDarkMode, label: "Total To Pay", value: transporter.estimatedTotal, isBold: true),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            _expandableTile(isDarkMode, "Terms & Conditions"),
            SizedBox(height: 12.h),
            _expandableTile(isDarkMode, "Reviews (4)"),

            SizedBox(height: 24.h),
            _sectionTitle("Get Support Anytime", isDarkMode),
            _buildSectionCard(
              isDarkMode,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A80F0).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.headset_mic_outlined, color: const Color(0xFF4A80F0), size: 28.sp),
                        SizedBox(height: 12.h),
                        Text(
                          "If you need help, we're available 24/7 from anywhere in the world.",
                          style: GoogleFonts.montserrat(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A80F0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        elevation: 0,
                      ),
                      child: Text(
                        "Contact Sendit Support",
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildSectionCard(bool isDarkMode, {required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }

  Widget _infoRow(bool isDarkMode, {required String icon, required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: SvgPicture.asset(icon, width: 20.w, height: 20.h, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
          ),
          SizedBox(width: 12.w),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(height: 1, color: Colors.grey.shade100);
  }

  Widget _pricingRow(bool isDarkMode, {required String label, required String value, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: isBold ? (isDarkMode ? Colors.white : Colors.black) : Colors.grey,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _expandableTile(bool isDarkMode, String title) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
        trailing: Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 24.sp),
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Text(
              "Placeholder content for $title",
              style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
