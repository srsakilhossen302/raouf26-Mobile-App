import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Utils/AppIcons/app_icons.dart';
import '../controller/transporter_new_requests_controller.dart';

class TransporterNewRequestsView extends StatelessWidget {
  const TransporterNewRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransporterNewRequestsController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "New Requests",
          style: GoogleFonts.montserrat(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20.r),
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildNewRequestCard(isDarkMode);
        },
      ),
    );
  }

  Widget _buildNewRequestCard(bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        children: [
          // Profile block
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: const NetworkImage("https://i.pravatar.cc/150?u=a042581f4e29026704d"),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Ahmad B.",
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        SvgPicture.asset(AppIcons.verifa, width: 14.w),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "5 hrs ago",
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "Pending",
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(color: isDarkMode ? Colors.white12 : Colors.grey.shade100, height: 1),
          SizedBox(height: 20.h),
          // Route block
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Icon(Icons.near_me_outlined, size: 20.sp, color: Colors.grey),
                  Container(
                    height: 24.h,
                    width: 1,
                    color: Colors.grey.shade300,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                  ),
                  Icon(Icons.location_on_outlined, size: 20.sp, color: Colors.grey),
                ],
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tunis",
                              style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            Text("14 Jan", style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey)),
                          ],
                        ),
                        Text("08:30 AM", style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Paris",
                              style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            Text("14 Jan", style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey)),
                          ],
                        ),
                        Text("10:45 PM", style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(color: isDarkMode ? Colors.white12 : Colors.grey.shade100, height: 1),
          SizedBox(height: 20.h),
          // Details block
          _buildDetailRow("Package Size", "Medium (15kg)", isDarkMode),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Status", style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.grey)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "Urgent",
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Estimate", style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
              Text("€25", style: GoogleFonts.montserrat(fontSize: 18.sp, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
            ],
          ),
          SizedBox(height: 20.h),
          // Actions block
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: BorderSide(color: Colors.redAccent.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(
                    "Reject",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    backgroundColor: const Color(0xFF4A80F0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(
                    "Accept",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.grey)),
        Text(value, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600, color: isDarkMode ? Colors.white : Colors.black)),
      ],
    );
  }
}
