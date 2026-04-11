import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../../Utils/AppIcons/app_icons.dart';
import '../Screen/Traveler-Roll/Dashboard/dashboard_view.dart';
import '../Screen/Traveler-Roll/MyParcels/my_parcels_view.dart';
import '../Screen/Traveler-Roll/Search/search_view.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavBar({super.key, required this.selectedIndex});

  void _onItemTapped(int index) {
    if (index == selectedIndex) return;

    switch (index) {
      case 0:
        Get.offAll(() => const DashboardScreen());
        break;
      case 1:
        Get.offAll(() => const MyParcelsScreen());
        break;
      case 2:
        Get.offAll(() => const SearchScreen());
        break;
      case 3:
        // Get.offAll(() => const MessagesScreen());
        break;
      case 4:
        // Get.offAll(() => const PublishTripsScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color fabColor = const Color(0xFF4A80F0);
    final Color activeColor = isDarkMode
        ? Colors.white
        : const Color(0xFF1A1A1A);
    final Color inactiveColor = isDarkMode
        ? Colors.white38
        : const Color(0xFF9E9E9E);

    return ConvexAppBar.builder(
      itemBuilder: _CustomTabBuilder(
        selectedIndex: selectedIndex,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        fabColor: fabColor,
        isDarkMode: isDarkMode,
      ),
      count: 5,
      backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      initialActiveIndex: selectedIndex,
      onTap: _onItemTapped,
      height: 75.h,
      curveSize: 100.w,
      top: -30.h,
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.1),
    );
  }
}

class _CustomTabBuilder extends DelegateBuilder {
  final int selectedIndex;
  final Color activeColor;
  final Color inactiveColor;
  final Color fabColor;
  final bool isDarkMode;

  _CustomTabBuilder({
    required this.selectedIndex,
    required this.activeColor,
    required this.inactiveColor,
    required this.fabColor,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context, int index, bool active) {
    String iconPath;
    String label;

    switch (index) {
      case 0:
        iconPath = AppIcons.dashboardNavbar;
        label = "Dashboard";
        break;
      case 1:
        iconPath = AppIcons.myParcelsNavbar;
        label = "My Parcels";
        break;
      case 2:
        iconPath = AppIcons.searchNavbar;
        label = "";
        break;
      case 3:
        iconPath = AppIcons.messagesNavbar;
        label = "Messages";
        break;
      case 4:
        iconPath = AppIcons.publishTripsNavbar;
        label = "Publish Trips";
        break;
      default:
        iconPath = AppIcons.dashboardNavbar;
        label = "";
    }

    if (index == 2) {
      return Container(
        margin: EdgeInsets.only(bottom: 25.h),
        decoration: BoxDecoration(
          color: fabColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: fabColor.withOpacity(0.3),
              blurRadius: 15.r,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 28.w,
            height: 28.w,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(top: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24.w,
            height: 24.w,
            colorFilter: ColorFilter.mode(
              active ? activeColor : inactiveColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 12.sp,
              color: active ? activeColor : inactiveColor,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
