import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../Utils/AppIcons/app_icons.dart';
import '../../../../../MessagesScreen/chat_view.dart';
import '../../controller/transporter_tracking_controller.dart';
import '../transporter_trip_details_view.dart';
import 'pickup_confirmation_sheet.dart';
import 'delivery_confirmation_sheet.dart';
import '../delivery_confirmation_page.dart';
import '../delivery_completed_page.dart';
import 'voice_call_sheet.dart';
import 'package:raouf26mobileapp/Utils/custom_snackbar.dart';

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
                                style: GoogleFonts.manrope(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                package.id,
                                style: GoogleFonts.manrope(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              // Quick Actions
                              Row(
                                children: [
                                  _buildQuickActionIcon(
                                    Icons.near_me_rounded,
                                    Colors.grey,
                                    () async {
                                      final url = Uri.parse(
                                          'https://www.google.com/maps/search/?api=1&query=${package.toCity}');
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        CustomSnackbar.error(title: "Error", message: "Could not launch maps");
                                      }
                                    },
                                  ),
                                  SizedBox(width: 12.w),
                                  _buildQuickActionIcon(
                                    Icons.message_rounded,
                                    Colors.grey,
                                    () => Get.to(() => ChatView(
                                          userData: {
                                            'name': package.userName,
                                            'image': package.userImage,
                                            'isSupport': false,
                                            'message': 'Hello, regarding package ${package.id}',
                                            'from': package.fromCity,
                                            'to': package.toCity,
                                            'price': '€${package.price.toStringAsFixed(0)}',
                                            'weight': package.packageSize,
                                          },
                                        )),
                                  ),
                                  SizedBox(width: 12.w),
                                  _buildQuickActionIcon(
                                    Icons.call_rounded,
                                    Colors.grey,
                                    () => showVoiceCallSheet(context, package),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "€${package.price.toStringAsFixed(0)}",
                        style: GoogleFonts.manrope(
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
                              () => TransporterTripDetailsView(
                                  package: package, controller: controller),
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
                            'view_details'.tr,
                            style: GoogleFonts.manrope(
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
                          onPressed: () => _onCTAPressed(context, package),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            backgroundColor: package.currentStatusStep == 3
                                ? Colors.green
                                : const Color(0xFF4A80F0),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            _getCTAText(package.currentStatusStep),
                            style: GoogleFonts.manrope(
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
          style: GoogleFonts.manrope(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  String _getCTAText(int statusStep) {
    switch (statusStep) {
      case 0:
        return 'confirm_pickup'.tr;
      case 1:
        return 'mark_in_transit'.tr;
      case 2:
        return 'confirm_delivery'.tr;
      case 3:
      default:
        return 'View Delivery Summary';
    }
  }

  void _onCTAPressed(BuildContext context, TrackingPackageModel package) {
    switch (package.currentStatusStep) {
      case 0:
        showPickupConfirmationSheet(context, package, controller);
        break;
      case 1:
        // Transition to In Transit
        controller.updatePackageStatus(package.id, 2);
        CustomSnackbar.success(
          title: "Success",
          message: "Package is now in transit!",
        );
        break;
      case 2:
        Get.to(() => DeliveryConfirmationPage(package: package, controller: controller));
        break;
      case 3:
        Get.to(() => DeliveryCompletedPage(package: package));
        break;
      default:
        break;
    }
  }

  Widget _buildQuickActionIcon(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.r),
        margin: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 18.sp),
      ),
    );
  }
}
