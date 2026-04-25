import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Utils/AppIcons/app_icons.dart';
import '../controller/transporter_tracking_controller.dart';
import 'widgets/pickup_confirmation_sheet.dart';
import 'widgets/delivery_confirmation_sheet.dart';
import '../../../MessagesScreen/chat_view.dart';
import '../../../MessagesScreen/report_issue_screen.dart';

class TransporterTripDetailsView extends StatelessWidget {
  final TrackingPackageModel package;
  final TransporterTrackingController controller;

  const TransporterTripDetailsView({
    super.key,
    required this.package,
    required this.controller,
  });

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
          style: GoogleFonts.manrope(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: isDarkMode ? Colors.white : Colors.black),
            onSelected: (value) {
              if (value == 'report') {
                Get.to(() => const ReportIssueScreen());
              } else if (value == 'contact') {
                Get.to(() => const ChatView(
                      userData: {
                        'name': 'Sendit Support',
                        'message': '24/7 available! How can we help you?',
                        'time': '',
                        'isSupport': true,
                        'isUnread': false,
                        'image': 'https://via.placeholder.com/150',
                        'subtitle': '',
                        'status': '',
                        'role': 'all',
                      },
                    ));
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'report',
                child: Row(
                  children: [
                    Icon(Icons.report_problem_outlined, size: 20.sp, color: Colors.redAccent),
                    SizedBox(width: 8.w),
                    Text('report_an_issue'.tr, style: GoogleFonts.manrope(fontSize: 14.sp)),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'contact',
                child: Row(
                  children: [
                    Icon(Icons.headset_mic_outlined, size: 20.sp, color: Colors.blue),
                    SizedBox(width: 8.w),
                    Text('contact_support'.tr, style: GoogleFonts.manrope(fontSize: 14.sp)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        final currentPackage = controller.packages.firstWhere(
          (pkg) => pkg.id == package.id,
          orElse: () => package,
        );
        return SingleChildScrollView(
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
                                backgroundImage: NetworkImage(currentPackage.userImage),
                                onBackgroundImageError: (_, __) {},
                                child: Icon(Icons.person, color: Colors.white, size: 20.sp),
                              ),
                              SizedBox(width: 12.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentPackage.userName,
                                    style: GoogleFonts.manrope(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    currentPackage.id,
                                    style: GoogleFonts.manrope(
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
                              color: _getStatusColor(currentPackage.currentStatusStep).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              _getStatusText(currentPackage.currentStatusStep),
                              style: GoogleFonts.manrope(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(currentPackage.currentStatusStep),
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
                                          style: GoogleFonts.manrope(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMode ? Colors.white : Colors.black,
                                          ),
                                        ),
                                        Text("${currentPackage.fromCity} \u2022 ${currentPackage.toCity}", style: GoogleFonts.manrope(fontSize: 12.sp, color: Colors.grey)),
                                      ],
                                    ),
                                    Text(currentPackage.fromTime, style: GoogleFonts.manrope(fontSize: 12.sp, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
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
                                          style: GoogleFonts.manrope(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMode ? Colors.white : Colors.black,
                                          ),
                                        ),
                                        Text("${currentPackage.toCity} \u2022 ${currentPackage.fromCity}", style: GoogleFonts.manrope(fontSize: 12.sp, color: Colors.grey)),
                                      ],
                                    ),
                                    Text(currentPackage.toTime, style: GoogleFonts.manrope(fontSize: 12.sp, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
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
                      _buildDetailRow('date'.tr, currentPackage.date, isDarkMode),
                      SizedBox(height: 16.h),
                      _buildDetailRow('price'.tr, "€${currentPackage.price.toStringAsFixed(0)}", isDarkMode, isBold: true),
                      SizedBox(height: 16.h),
                      _buildDetailRow('package_size'.tr, currentPackage.packageSize, isDarkMode),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('status'.tr, style: GoogleFonts.manrope(fontSize: 14.sp, color: Colors.grey)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              currentPackage.priority,
                              style: GoogleFonts.manrope(
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
                      _buildStatusTimeline(currentPackage.currentStatusStep, isDarkMode),
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
                                      style: GoogleFonts.manrope(
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
                    onPressed: () => _onCTAPressed(context, currentPackage),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentPackage.currentStatusStep == 3 ? Colors.green : const Color(0xFF4A80F0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text(
                      _getCTAText(currentPackage.currentStatusStep),
                      style: GoogleFonts.manrope(
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
        );
      }),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDarkMode, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.manrope(fontSize: 14.sp, color: Colors.grey)),
        Text(
          value,
          style: GoogleFonts.manrope(
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
            bool isReached = index <= currentStep;
            return Text(
              steps[index].tr,
              style: GoogleFonts.manrope(
                fontSize: 10.sp,
                fontWeight: isReached ? FontWeight.bold : FontWeight.normal,
                color: isReached
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
                bool isReached = index <= currentStep;
                bool isCompleted = index < currentStep;
                return Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    color: isCompleted ? const Color(0xFF4A80F0) : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isReached ? const Color(0xFF4A80F0) : Colors.grey.shade300,
                      width: isReached ? 3.w : 2.w,
                    ),
                    boxShadow: [
                      if (isReached)
                        BoxShadow(
                          color: const Color(0xFF4A80F0).withOpacity(0.2),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                    ],
                  ),
                );
              }),
            ),
            // Blue active line
            Positioned(
              left: 0,
              child: Container(
                height: 2.h,
                width: (Get.width - 80.w) * (currentStep / (steps.length - 1)),
                color: const Color(0xFF4A80F0),
              ),
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
        showPickupConfirmationSheet(context, package, controller);
        break;
      case 1:
        controller.updatePackageStatus(package.id, 2);
        Get.snackbar(
          "Success",
          "Package is now in transit!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
        break;
      case 2:
        showDeliveryConfirmationSheet(context, package, controller);
        break;
      default:
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
