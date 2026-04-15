import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Tracking",
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
              icon: Icon(
                controller.isMapView.value ? Icons.format_list_bulleted : Icons.map_outlined,
                color: isDarkMode ? Colors.white : Colors.black,
                size: 26.sp,
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
      bottomNavigationBar: const CustomTransporterBottomNavBar(selectedIndex: 1),
      body: SafeArea(
        child: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: controller.isMapView.value
                ? TrackingMapWidget(controller: controller, isDarkMode: isDarkMode)
                : TrackingListWidget(controller: controller, isDarkMode: isDarkMode),
          ),
        ),
      ),
    );
  }
}
