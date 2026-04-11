import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Transporters/transporters_controller.dart';
import 'package:raouf26mobileapp/utils/appicons/app_icons.dart';

class TransportersView extends GetView<TransportersController> {
  const TransportersView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TransportersController());
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
          "Transporters",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: SvgPicture.asset(
              AppIcons.filters,
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                isDarkMode ? Colors.white : Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Location...",
                  hintStyle: GoogleFonts.montserrat(color: Colors.grey, fontSize: 14.sp),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey, size: 22.sp),
                ),
              ),
            ),
          ),

          // Filters
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: controller.filters.map((filter) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: filter == controller.filters.last ? 0 : 8.w),
                  child: Obx(() => GestureDetector(
                    onTap: () => controller.setFilter(filter),
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: controller.selectedFilter.value == filter
                            ? const Color(0xFF1A1A1A)
                            : (isDarkMode ? Colors.grey.shade900 : Colors.white),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: controller.selectedFilter.value == filter
                              ? Colors.transparent
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          filter,
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: controller.selectedFilter.value == filter
                                ? Colors.white
                                : (isDarkMode ? Colors.white70 : Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  )),
                ),
              )).toList(),
            ),
          ),

          SizedBox(height: 16.h),

          // Info Banner
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: const Color(0xFF4A80F0).withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: const Color(0xFF4A80F0), size: 18.sp),
                  SizedBox(width: 8.w),
                  Text(
                    "4 Transporters Found!",
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Transporters List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: controller.transporters.length,
              itemBuilder: (context, index) {
                final transporter = controller.transporters[index];
                return _transporterCard(transporter, isDarkMode);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _transporterCard(Transporter transporter, bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
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
                          style: GoogleFonts.montserrat(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.check_circle, color: Colors.blue, size: 14.sp),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 14.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "${transporter.rating} • ${transporter.totalTrips} Trips",
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
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
                  style: GoogleFonts.montserrat(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.black26 : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              children: [
                _routeRow(Icons.near_me_outlined, transporter.from, transporter.fromDate, transporter.fromTime, isDarkMode),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 1,
                      height: 20.h,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                _routeRow(Icons.location_on_outlined, transporter.to, transporter.toDate, transporter.toTime, isDarkMode),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Price Per kg", style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey)),
                  Text(transporter.pricePerKg, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Estimated Total", style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey)),
                  Text(transporter.estimatedTotal, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                ],
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            children: [
              Text(
                "Also traveling to ${transporter.alsoTravelingTo.join(', ')}",
                style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
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
              Text(
                city,
                style: GoogleFonts.montserrat(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                date,
                style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
      ],
    );
  }
}
