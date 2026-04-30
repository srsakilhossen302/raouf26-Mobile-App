import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/PublishTrips/Controllers/publish_trip_flow_controller.dart';
import '../../../../../Utils/AppIcons/app_icons.dart';
import '../Models/trip_model.dart';
import 'package:raouf26mobileapp/View/Screen/MessagesScreen/chat_view.dart';
import 'package:raouf26mobileapp/View/Screen/MessagesScreen/report_issue_screen.dart';
import 'publish_trip_flow_screen.dart';

class TripDetailsScreen extends StatelessWidget {
  final TripModel trip;

  const TripDetailsScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          "Trip Details",
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: Icon(
              Icons.more_vert,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            onSelected: (value) {
              if (value == 0) {
                Get.to(() => const ReportIssueScreen());
              } else if (value == 1) {
                Get.to(() => const ChatView(
                      userData: {
                        'name': 'Sendit Support',
                        'message': '24/7 available! How can we help you?',
                        'time': '',
                        'isSupport': true,
                        'isUnread': false,
                        'image': '',
                      },
                    ));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.report_problem_outlined,
                      size: 20.sp,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "report_an_issue".tr,
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.headset_mic_outlined,
                      size: 20.sp,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "contact_support".tr,
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  // Route Details Card
                  _buildDetailsCard(
                    title: "Route Details",
                    isDarkMode: isDarkMode,
                    onEdit: () {
                      final controller = Get.put(PublishTripFlowController());
                      controller.populateFromTrip(trip);
                      controller.currentStep.value = 1;
                      controller.isEditMode.value = true;
                      controller.isFromDetailsScreen.value = true;
                      Get.to(() => const PublishTripFlowScreen());
                    },
                    child: Column(
                      children: [
                        _buildRouteRow(
                          icon: Icons.near_me_outlined,
                          location: trip.departureCity,
                          date: trip.departureDate,
                          time: trip.departureTime,
                          isDarkMode: isDarkMode,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: List.generate(4, (index) => Container(
                                width: 1.w,
                                height: 3.h,
                                margin: EdgeInsets.symmetric(vertical: 2.h),
                                color: Colors.grey.shade300,
                              )),
                            ),
                          ),
                        ),
                        _buildRouteRow(
                          icon: Icons.location_on_outlined,
                          location: trip.arrivalCity,
                          date: trip.arrivalDate,
                          time: trip.arrivalTime,
                          isDarkMode: isDarkMode,
                        ),
                        SizedBox(height: 16.h),
                        const Divider(height: 1),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Stops",
                              style: GoogleFonts.manrope(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Text(
                                trip.stops,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.manrope(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Trip Details Card
                  _buildDetailsCard(
                    title: "Trip Details",
                    isDarkMode: isDarkMode,
                    onEdit: () {
                      final controller = Get.put(PublishTripFlowController());
                      controller.populateFromTrip(trip);
                      controller.currentStep.value = 2;
                      controller.isEditMode.value = true;
                      controller.isFromDetailsScreen.value = true;
                      Get.to(() => const PublishTripFlowScreen());
                    },
                    child: Column(
                      children: [
                        _buildDetailItem("Departure Date & Time", "${trip.departureDate} - ${trip.departureTime}", isDarkMode),
                        _buildDetailItem("Arrival Date & Time", "${trip.arrivalDate} - ${trip.arrivalTime}", isDarkMode),
                        _buildDetailItem("Maximum Weight Available:", trip.maxWeight, isDarkMode),
                        _buildDetailItem("Price Per kg", trip.pricePerKg, isDarkMode),
                        _buildDetailItem("Travel Mode", trip.travelMode, isDarkMode, showDivider: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Buttons
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(24.w),
              color: isDarkMode ? Colors.transparent : Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A80F0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text(
                        "Complete Trip",
                        style: GoogleFonts.manrope(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFFFEAEA)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text(
                        "Delete Trip",
                        style: GoogleFonts.manrope(fontSize: 16.sp, fontWeight: FontWeight.w700, color: const Color(0xFFFF3B3B)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard({required String title, required Widget child, required bool isDarkMode, VoidCallback? onEdit}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(fontSize: 16.sp, fontWeight: FontWeight.w700, color: isDarkMode ? Colors.white : Colors.black),
              ),
              GestureDetector(
                onTap: onEdit,
                child: SvgPicture.asset(
                  AppIcons.edit,
                  width: 20.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          child,
        ],
      ),
    );
  }

  Widget _buildRouteRow({required IconData icon, required String location, required String date, required String time, required bool isDarkMode}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18.sp, color: Colors.black54),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(location, style: GoogleFonts.manrope(fontSize: 14.sp, fontWeight: FontWeight.w700, color: isDarkMode ? Colors.white : Colors.black)),
              Text(date, style: GoogleFonts.manrope(fontSize: 12.sp, color: Colors.grey)),
            ],
          ),
        ),
        Text(time, style: GoogleFonts.manrope(fontSize: 14.sp, fontWeight: FontWeight.w500, color: isDarkMode ? Colors.white : Colors.black87)),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, bool isDarkMode, {bool showDivider = true}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.manrope(fontSize: 14.sp, color: Colors.grey),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider) Divider(height: 1, color: Colors.grey.withOpacity(0.1)),
      ],
    );
  }
}
