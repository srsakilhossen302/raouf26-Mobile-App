import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Transporters/transporters_controller.dart';

class TransporterDetailsView extends StatelessWidget {
  final Transporter transporter;
  const TransporterDetailsView({super.key, required this.transporter});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: isDarkMode ? Colors.white : Colors.black, size: 28.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Transporter Details",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tue 20 Jan, 2026",
                    style: GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  
                  // Route Info Box
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Complete Route",
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        // From-To Visualization
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black26 : Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.near_me_outlined, color: const Color(0xFF4A80F0), size: 24.sp),
                                  SizedBox(height: 4.h),
                                  Text(transporter.from, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SvgPicture.string(
                                '<svg width="80" height="20" viewBox="0 0 80 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M0 10H70" stroke="#4A80F0" stroke-width="2" stroke-dasharray="4 4"/><path d="M70 10L62 5V15L70 10Z" fill="#4A80F0"/></svg>',
                              ),
                              Column(
                                children: [
                                  Icon(Icons.location_on_outlined, color: const Color(0xFF4A80F0), size: 24.sp),
                                  SizedBox(height: 4.h),
                                  Text(transporter.to, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        // Timeline Route
                        _timelineRouteItem("08:30 AM", "12 Avenue Habib Bourguiba, Tunis, Tunisia", "20 Jan", true, false),
                        _timelineRouteItem("01:00 PM", "21 Via del Corso, Rome, Italy", "20 Jan", false, false),
                        _timelineRouteItem("04:30 PM", "9 Bahnhofstrasse, Zürich, Switzerland", "20 Jan", false, false),
                        _timelineRouteItem("09:30 PM", "18 Rue de Rivoli, Paris, France", "20 Jan", false, true),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Pricing Box
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pricing", style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w700)),
                        SizedBox(height: 16.h),
                        _pricingRow("Price Per kg", transporter.pricePerKg, isDarkMode),
                        const Divider(),
                        _pricingRow("Estimated Total (15kg)", transporter.estimatedTotal, isDarkMode, isBold: true),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Transporter Info Box
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage: NetworkImage(transporter.imageUrl),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    transporter.name,
                                    style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(Icons.check_circle, color: Colors.blue, size: 14.sp),
                                ],
                              ),
                              Text(
                                "Verified Profile",
                                style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            transporter.vehicleType,
                            style: GoogleFonts.montserrat(fontSize: 10.sp, fontWeight: FontWeight.w600, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.r),
            child: SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  // Book logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  elevation: 0,
                ),
                child: Text(
                  "Book Transporter",
                  style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timelineRouteItem(String time, String address, String date, bool isFirst, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 70.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            children: [
              Container(
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF4A80F0), width: 2),
                  color: Colors.white,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: const Color(0xFF4A80F0),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address,
                  style: GoogleFonts.montserrat(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  date,
                  style: GoogleFonts.montserrat(
                    fontSize: 11.sp,
                    color: Colors.grey,
                  ),
                ),
                if (!isLast) SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pricingRow(String label, String value, bool isDarkMode, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              color: isDarkMode ? Colors.white70 : Colors.black54,
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
      ),
    );
  }
}
