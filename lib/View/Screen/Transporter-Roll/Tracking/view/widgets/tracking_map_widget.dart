import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../Utils/AppIcons/app_icons.dart';
import '../../controller/transporter_tracking_controller.dart';
import '../transporter_trip_details_view.dart';
import 'pickup_confirmation_sheet.dart';
import 'delivery_confirmation_sheet.dart';

class TrackingMapWidget extends StatelessWidget {
  final TransporterTrackingController controller;
  final bool isDarkMode;

  const TrackingMapWidget({
    super.key,
    required this.controller,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map Area Mockup
        Container(
          width: double.infinity,
          height: double.infinity,
          color: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FE),
          child: Stack(
            children: [
              _buildMapMarker(100.h, 50.w, false),
              _buildMapMarker(250.h, 80.w, false),
              _buildMapMarker(180.h, 250.w, false),
              _buildMapMarker(300.h, 280.w, false),
              _buildMapMarker(400.h, 180.w, false),
              // Highlighted Center Marker
              _buildMapMarker(180.h, 150.w, true),
            ],
          ),
        ),

        // Bottom Map Card
        Positioned(
          bottom: 20.h,
          left: 20.w,
          right: 20.w,
          child: Obx(() {
            if (controller.packages.isEmpty) return const SizedBox();
            // Show the first one as selected for mockup
            final package = controller.packages[0];

            return Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundImage: NetworkImage(package.userImage),
                            onBackgroundImageError: (_, __) {},
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                package.userName,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                package.id,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "€${package.price.toStringAsFixed(0)}",
                        style: GoogleFonts.montserrat(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Route Line
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildRouteLocationIcon(
                        AppIcons.departure,
                        package.fromCity,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      (constraints.constrainWidth() / 8)
                                          .floor(),
                                      (index) => SizedBox(
                                        width: 4.w,
                                        height: 2.h,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.blue,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),
                      _buildRouteLocationIcon(
                        AppIcons.location,
                        package.toCity,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Get.to(
                              () =>
                                  TransporterTripDetailsView(package: package),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            side: BorderSide(
                              color: isDarkMode
                                  ? Colors.white24
                                  : Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "View Details",
                            style: GoogleFonts.montserrat(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showPickupConfirmationSheet(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            backgroundColor: const Color(0xFF4A80F0),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "Mark as Delivered",
                            style: GoogleFonts.montserrat(
                              fontSize: 12.sp,
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
          }),
        ),
      ],
    );
  }

  Widget _buildMapMarker(double top, double left, bool isHighlighted) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: isHighlighted ? Colors.black : Colors.blue.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          AppIcons.trackingNavbar,
          colorFilter: ColorFilter.mode(
            isHighlighted ? Colors.white : Colors.blue,
            BlendMode.srcIn,
          ),
          width: isHighlighted ? 28.sp : 18.sp,
        ),
      ),
    );
  }

  Widget _buildRouteLocationIcon(String iconPath, String city) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            iconPath,
            colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
            width: 16.w,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          city,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
