import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Utils/AppIcons/app_icons.dart';
import '../controller/transporter_tracking_controller.dart';
import 'widgets/pickup_confirmation_sheet.dart';
import 'widgets/delivery_confirmation_sheet.dart';

class TransporterTripDetailsView extends StatelessWidget {
  final TrackingPackageModel package;

  const TransporterTripDetailsView({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          package.id.replaceAll("#", ""),
          style: GoogleFonts.montserrat(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: isDarkMode ? Colors.white : Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Container(
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
                    // Profile Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20.r,
                              backgroundImage: NetworkImage(package.userImage),
                              onBackgroundImageError: (_, __) {},
                              child: Icon(Icons.person, color: Colors.white, size: 20.sp),
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
                                    color: isDarkMode ? Colors.white : Colors.black,
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: _getStatusColor(package.currentStatusStep).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            _getStatusText(package.currentStatusStep),
                            style: GoogleFonts.montserrat(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(package.currentStatusStep),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Divider(color: isDarkMode ? Colors.white12 : Colors.grey.shade100, height: 1),
                    SizedBox(height: 24.h),

                    // Route Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(AppIcons.departure, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn), width: 16.w),
                            Container(
                              height: 24.h,
                              width: 1,
                              color: Colors.grey.shade300,
                              margin: EdgeInsets.symmetric(vertical: 4.h),
                            ),
                            SvgPicture.asset(AppIcons.location, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn), width: 16.w),
                          ],
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'pickup_status'.tr,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: isDarkMode ? Colors.white : Colors.black,
                                        ),
                                      ),
                                      Text("${package.fromCity} \u2022 ${package.toCity}", style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey)),
                                    ],
                                  ),
                                  Text(package.fromTime, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
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
                                        'drop_off'.tr,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: isDarkMode ? Colors.white : Colors.black,
                                        ),
                                      ),
                                      Text("${package.toCity} \u2022 ${package.fromCity}", style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey)),
                                    ],
                                  ),
                                  Text(package.toTime, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Divider(color: isDarkMode ? Colors.white12 : Colors.grey.shade100, height: 1),
                    SizedBox(height: 24.h),

                    // Package details List
                    _buildDetailRow('date'.tr, package.date, isDarkMode),
                    SizedBox(height: 16.h),
                    _buildDetailRow('price'.tr, "€${package.price.toStringAsFixed(0)}", isDarkMode, isBold: true),
                    SizedBox(height: 16.h),
                    _buildDetailRow('package_size'.tr, package.packageSize, isDarkMode),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('status'.tr, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.grey)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            package.priority,
                            style: GoogleFonts.montserrat(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Divider(color: isDarkMode ? Colors.white12 : Colors.grey.shade100, height: 1),
                    SizedBox(height: 24.h),

                    // Timeline
                    _buildStatusTimeline(package.currentStatusStep, isDarkMode),
                    SizedBox(height: 24.h),

                    // Mini Map 
                    Container(
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.black26 : const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.map, size: 80.sp, color: isDarkMode ? Colors.white10 : Colors.black12),
                          Positioned(
                            top: 40.h,
                            left: 40.w,
                            child: SvgPicture.asset(AppIcons.departure, colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn), width: 24.w),
                          ),
                          Positioned(
                            bottom: 40.h,
                            right: 40.w,
                            child: SvgPicture.asset(AppIcons.location, colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn), width: 24.w),
                          ),
                          Positioned(
                            bottom: 10.h,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on, size: 14.sp, color: Colors.black),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'open_full_map'.tr,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              
              // Bottom Huge Button
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () => _onCTAPressed(context, package),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: package.currentStatusStep == 3 ? Colors.green : const Color(0xFF4A80F0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(
                    _getCTAText(package.currentStatusStep),
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDarkMode, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.grey)),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusTimeline(int currentStep, bool isDarkMode) {
    const steps = ["Booked", "Picked Up", "In Transit", "Delivered"];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(steps.length, (index) {
            return Text(
              steps[index].tr,
              style: GoogleFonts.montserrat(
                fontSize: 10.sp,
                fontWeight: index <= currentStep ? FontWeight.bold : FontWeight.normal,
                color: index <= currentStep
                    ? (isDarkMode ? Colors.white : Colors.black)
                    : Colors.grey,
              ),
            );
          }),
        ),
        SizedBox(height: 8.h),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 2.h,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(steps.length, (index) {
                bool isActive = index <= currentStep;
                return Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : Colors.grey.shade300,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? const Color(0xFF4A80F0) : Colors.transparent,
                      width: 3.w,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  String _getCTAText(int statusStep) {
    switch (statusStep) {
      case 0: return 'confirm_pickup'.tr;
      case 1: return 'mark_in_transit'.tr;
      case 2: return 'confirm_delivery'.tr;
      case 3: default: return 'view_proof'.tr;
    }
  }

  void _onCTAPressed(BuildContext context, TrackingPackageModel package) {
    switch (package.currentStatusStep) {
      case 0:
        showPickupConfirmationSheet(context, package);
        break;
      case 1:
        // Future logic to mark as in transit
        break;
      case 2:
        showDeliveryConfirmationSheet(context, package);
        break;
      case 3:
      default:
        // Future logic to view proof of delivery
        break;
    }
  }

  String _getStatusText(int statusStep) {
    switch (statusStep) {
      case 0: return 'booked_status'.tr;
      case 1: return 'picked_up'.tr;
      case 2: return 'in_transit'.tr;
      case 3: default: return 'delivered_status'.tr;
    }
  }

  Color _getStatusColor(int statusStep) {
    switch (statusStep) {
      case 0: return Colors.orange;
      case 1: return Colors.purple;
      case 2: return Colors.blue;
      case 3: default: return Colors.green;
    }
  }
}
