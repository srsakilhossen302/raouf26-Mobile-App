import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/BookingRequest/booking_request_controller.dart';
import '../../../../Utils/AppIcons/app_icons.dart';

class BookingRequestView extends GetView<BookingRequestController> {
  const BookingRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BookingRequestController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: NetworkImage(controller.transporterImage.value),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      controller.transporterName.value,
                      style: GoogleFonts.montserrat(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    SvgPicture.asset(
                      AppIcons.verifa,
                      width: 14.w,
                      height: 14.h,
                    ),
                  ],
                ),
                Text(
                  "Online",
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.info_outline, color: isDarkMode ? Colors.white : Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.r),
              child: Column(
                children: [
                  // Info Banner
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A80F0).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info, color: const Color(0xFF4A80F0), size: 20.sp),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            "Message is blocked until transporter accepts your reservation",
                            style: GoogleFonts.montserrat(
                              fontSize: 13.sp,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Booking Request Card
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Booking Request",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Text(
                                    controller.deliverySpeed.value,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SvgPicture.asset(AppIcons.edit, width: 20.w, height: 20.h, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        
                        // Route Box
                        Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black26 : Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Route", style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                              SizedBox(height: 12.h),
                              _routeRow(Icons.near_me_outlined, controller.fromCity.value, controller.fromDate.value, controller.fromTime.value, isDarkMode),
                              Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Container(
                                  width: 1,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    border: Border(left: BorderSide(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid)),
                                  ),
                                  child: const VerticalDivider(color: Colors.grey, thickness: 1, indent: 2, endIndent: 2),
                                ),
                              ),
                              _routeRow(Icons.location_on_outlined, controller.toCity.value, controller.toDate.value, controller.toTime.value, isDarkMode),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 16.h),

                        // Package Summary Box
                        Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black26 : Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Package Summary", style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                              SizedBox(height: 16.h),
                              _summaryRow("Package Size", controller.packageSize.value, isDarkMode),
                              const Divider(),
                              _summaryRow("Delivery Time", controller.deliveryTime.value, isDarkMode),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Package Photos", style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.grey)),
                                  Row(
                                    children: [
                                      _photoThumbnail("https://images.unsplash.com/photo-1580915411954-282cb1b0d780?q=80&w=100"),
                                      SizedBox(width: 8.w),
                                      _photoThumbnail("https://images.unsplash.com/photo-1566576721346-d4a3b4eaad5b?q=80&w=100"),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Status", style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.grey)),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, color: const Color(0xFF4A80F0), size: 16.sp),
                                      SizedBox(width: 4.w),
                                      Text(
                                        controller.bookingStatus.value,
                                        style: GoogleFonts.montserrat(fontSize: 13.sp, color: const Color(0xFF4A80F0), fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(),
                              _summaryRow("Total Estimate", controller.totalEstimate.value, isDarkMode, isBold: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Cancel Button
          Padding(
            padding: EdgeInsets.all(24.r),
            child: SizedBox(
              width: double.infinity,
              height: 56.h,
              child: OutlinedButton(
                onPressed: () => controller.cancelReservation(),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text(
                  "Cancel Reservation",
                  style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _routeRow(IconData icon, String city, String date, String time, bool isDarkMode) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 18.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(city, style: GoogleFonts.montserrat(fontSize: 13.sp, fontWeight: FontWeight.w600)),
              Text(date, style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey)),
            ],
          ),
        ),
        Text(time, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _summaryRow(String label, String value, bool isDarkMode, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.grey)),
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 13.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoThumbnail(String url) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}
