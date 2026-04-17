import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Widget/custom_transporter_bottom_nav_bar.dart';
import '../controller/transporter_tracking_controller.dart';
import 'widgets/tracking_list_widget.dart';
import 'widgets/tracking_map_widget.dart';

class TransporterTrackingView extends StatelessWidget {
  const TransporterTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransporterTrackingController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'tracking'.tr,
          style: GoogleFonts.montserrat(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: controller.toggleView,
              icon: SvgPicture.asset(
                controller.isMapView.value
                    ? AppIcons.manuIcons
                    : AppIcons.fullMapIcons,
                colorFilter: ColorFilter.mode(
                  isDarkMode ? Colors.white : Colors.black,
                  BlendMode.srcIn,
                ),
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF4A80F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        elevation: 4,
        child: Icon(Icons.add, color: Colors.white, size: 28.sp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomTransporterBottomNavBar(
        selectedIndex: 1,
      ),
      body: SafeArea(
        child: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: controller.isMapView.value
                ? TrackingMapWidget(
                    controller: controller,
                    isDarkMode: isDarkMode,
                  )
                : TrackingListWidget(
                    controller: controller,
                    isDarkMode: isDarkMode,
                  ),
          ),
        ),
      ),
    );
  }
}
