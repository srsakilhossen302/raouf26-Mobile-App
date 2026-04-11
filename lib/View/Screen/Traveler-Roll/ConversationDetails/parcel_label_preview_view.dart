import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ParcelLabelPreviewView extends StatelessWidget {
  const ParcelLabelPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              "Parcel Label Preview",
              style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.close, color: isDarkMode ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tracking ID
                  Text(
                    "Tracking ID:",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  Text(
                    "SNDT-482913-28JAN",
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const Divider(),
                  SizedBox(height: 16.h),

                  // FROM
                  _addressSection("FROM:", "Zain Malik", "12 Avenue Habib Bourguiba, Tunis,\nTunisia\n+216 00 000 000", isDarkMode),
                  SizedBox(height: 24.h),
                  const Divider(),
                  SizedBox(height: 16.h),

                  // To
                  _addressSection("To:", "Ahmed Bin Salah", "18 Rue de Rivoli, Paris\nFrance\n+216 00 000 000", isDarkMode),
                  SizedBox(height: 24.h),
                  const Divider(),
                  SizedBox(height: 16.h),

                  // SHIPMENT DETAILS
                  Text(
                    "SHIPMENT DETAILS",
                    style: GoogleFonts.montserrat(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Ahmed Bin Salah",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Route",
                    style: GoogleFonts.montserrat(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Tunis → Paris",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _detailColumn("Parcel Type", "Small Box", isDarkMode),
                      _detailColumn("Weight", "2.4 kg", isDarkMode),
                      _detailColumn("Date", "28 Jan 2026", isDarkMode),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  // Barcode Placeholder
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 60.h,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(40, (index) {
                              return Container(
                                width: (index % 3 == 0) ? 4.w : 2.w,
                                height: 60.h,
                                margin: EdgeInsets.only(right: 2.w),
                                color: isDarkMode ? Colors.white : Colors.black,
                              );
                            }),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "SNDT48291328JAN",
                          style: GoogleFonts.montserrat(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: Text(
                      "Please attach this label securely to your parcel",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Print",
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addressSection(String label, String name, String address, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 11.sp,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          name,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          address,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            color: Colors.grey,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _detailColumn(String label, String value, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 11.sp,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }
}
