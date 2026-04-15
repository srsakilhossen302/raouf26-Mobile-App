import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Utils/AppIcons/app_icons.dart';
import '../Screen/MessagesScreen/messages_view.dart';
import '../Screen/Transporter-Roll/Home/view/transporter_home_view.dart';
import '../Screen/Transporter-Roll/Tracking/view/transporter_tracking_view.dart';
import '../Screen/Traveler-Roll/PublishTrips/Views/publish_trips_screen.dart';

class CustomTransporterBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomTransporterBottomNavBar({super.key, required this.selectedIndex});

  static Widget buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // Post trip or other logic for transporters
      },
      backgroundColor: const Color(0xFF4A80F0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      elevation: 4,
      child: Icon(Icons.add, color: Colors.white, size: 28.sp),
    );
  }

  void _onItemTapped(int index) {
    if (index == selectedIndex) return;

    switch (index) {
      case 0:
        Get.offAll(() => const TransporterHomeScreen());
        break;
      case 1:
        Get.offAll(() => const TransporterTrackingView());
        break;
      case 3:
        Get.offAll(() => const MessagesScreen());
        break;
      case 4:
        Get.offAll(() => const PublishTripsScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color activeColor = isDarkMode
        ? Colors.white
        : const Color(0xFF1A1A1A);
    final Color inactiveColor = isDarkMode
        ? Colors.white38
        : const Color(0xFF9E9E9E);

    return BottomAppBar(
      color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      elevation: 20,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 65.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildNavItem(
                AppIcons.dashboardNavbar,
                "Dashboard",
                0,
                selectedIndex == 0,
                activeColor,
                inactiveColor,
              ),
            ),
            Expanded(
              child: _buildNavItem(
                AppIcons.trackingNavbar,
                "Tracking",
                1,
                selectedIndex == 1,
                activeColor,
                inactiveColor,
              ),
            ),
            SizedBox(width: 48.w), // Space for the floating action button
            Expanded(
              child: _buildNavItem(
                AppIcons.messagesNavbar,
                "Messages",
                3,
                selectedIndex == 3,
                activeColor,
                inactiveColor,
              ),
            ),
            Expanded(
              child: _buildNavItem(
                AppIcons.publishTripsNavbar,
                "Trips",
                4,
                selectedIndex == 4,
                activeColor,
                inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String iconPath,
    String label,
    int index,
    bool isActive,
    Color activeColor,
    Color inactiveColor,
  ) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24.w,
            height: 24.w,
            colorFilter: ColorFilter.mode(
              isActive ? activeColor : inactiveColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 11.sp,
              color: isActive ? activeColor : inactiveColor,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
