import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Utils/AppImg/app_img.dart';
import '../../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Widget/custom_transporter_bottom_nav_bar.dart';
import '../controller/transporter_home_controller.dart';
import '../../Notifications/view/transporter_notifications_view.dart';
import '../../NewRequests/view/transporter_new_requests_view.dart';
import '../../RateDelivery/view/rate_delivery_sheet.dart';
import '../../../Traveler-Roll/Profile/profile_page.dart';
import '../../../Traveler-Roll/Profile/payment_method_page.dart';

class TransporterHomeScreen extends StatelessWidget {
  const TransporterHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransporterHomeController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FB),
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
        selectedIndex: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            _buildHeader(isDarkMode),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  _buildSectionHeader(
                    'new_requests'.tr,
                    'see_all'.tr,
                    isDarkMode,
                    onTap: () =>
                        Get.to(() => const TransporterNewRequestsView()),
                  ),
                  SizedBox(height: 16.h),
                  _buildNewRequestsList(controller, isDarkMode),

                  SizedBox(height: 24.h),
                  _buildSectionHeader(
                    'active_deliveries'.tr,
                    'see_all'.tr,
                    isDarkMode,
                    onTap: () => showRateDeliverySheet(context),
                  ),
                  SizedBox(height: 16.h),
                  _buildActiveDeliveriesList(controller, isDarkMode),

                  SizedBox(height: 24.h),
                  _buildSectionHeader('republish_trips'.tr, "", isDarkMode),
                  SizedBox(height: 16.h),
                  _buildRepublishTrips(isDarkMode),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDarkMode) {
    return Stack(
      children: [
        Container(
          height: 220.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF4A80F0),
            image: DecorationImage(
              image: AssetImage(AppImg.dashboardBg),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              // Master Activity Card
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    if (!isDarkMode)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Row
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.to(() => const ProfilePage()),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25.r,
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage: const NetworkImage(
                                    "https://i.pravatar.cc/150?u=zain",
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hi, Zain Malik",
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'new_delivery_requests'.tr,
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.white70
                                            : Colors.grey.shade600,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // QR Code Icon
                        GestureDetector(
                          onTap: () {
                            // QR Scanner logic
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white10
                                  : const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.qr_code_scanner,
                              color: isDarkMode ? Colors.white : Colors.black87,
                              size: 22.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Notifications Icon
                        GestureDetector(
                          onTap: () => Get.to(
                            () => const TransporterNotificationsView(),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white10
                                  : const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.notifications_none,
                              color: isDarkMode ? Colors.white : Colors.black87,
                              size: 22.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    // Activity Overview Title
                    Text(
                      'activity_overview'.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Stats Row
                    Row(
                      children: [
                        _buildStatCard(
                          'total_earnings'.tr,
                          "€1,240",
                          AppIcons.totalEarnings,
                          Colors.blue,
                          isDarkMode,
                          onTap: () => Get.to(() => const PaymentMethodPage()),
                        ),
                        SizedBox(width: 8.w),
                        _buildStatCard(
                          'active_clients'.tr,
                          "1,240",
                          AppIcons.clients,
                          Colors.green,
                          isDarkMode,
                        ),
                        SizedBox(width: 8.w),
                        _buildStatCard(
                          'rating'.tr,
                          "4.8",
                          "assets/icons/Rating.svg",
                          Colors.orange,
                          isDarkMode,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    String iconPath,
    Color color,
    bool isDarkMode, {
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: isDarkMode
                ? null
                : Border.all(color: Colors.grey.shade100, width: 1.5),
            boxShadow: [
              if (!isDarkMode)
                BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  height: 20.sp,
                  width: 20.sp,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                label,
                style: TextStyle(fontSize: 10.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    String action,
    bool isDarkMode, {
    VoidCallback? onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        if (action.isNotEmpty)
          GestureDetector(
            onTap: onTap,
            child: Text(
              action,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          ),
      ],
    );
  }

  Widget _buildNewRequestsList(
    TransporterHomeController controller,
    bool isDarkMode,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: controller.newRequests
            .map((request) => _buildRequestCard(request, isDarkMode))
            .toList(),
      ),
    );
  }

  Widget _buildRequestCard(RequestModel request, bool isDarkMode) {
    return Container(
      width: 200.w,
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${request.from} → ${request.to}",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                request.price,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            "${request.date} \u2022 ${request.time}",
            style: TextStyle(fontSize: 10.sp, color: Colors.grey),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              CircleAvatar(
                radius: 12.r,
                backgroundImage: NetworkImage(request.userImage),
              ),
              SizedBox(width: 8.w),
              Text(
                request.userName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(width: 4.w),
              SvgPicture.asset(AppIcons.verifa, width: 14.w, height: 14.h),
              const Spacer(),
              Text(
                "5h ago",
                style: TextStyle(fontSize: 10.sp, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveDeliveriesList(
    TransporterHomeController controller,
    bool isDarkMode,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: controller.activeDeliveries
            .map((delivery) => _buildDeliveryCard(delivery, isDarkMode))
            .toList(),
      ),
    );
  }

  Widget _buildDeliveryCard(DeliveryModel delivery, bool isDarkMode) {
    return Container(
      width: 200.w,
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                delivery.pkgId,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: delivery.status == "In Transit"
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  delivery.status,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: delivery.status == "In Transit"
                        ? Colors.blue
                        : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            delivery.route,
            style: TextStyle(fontSize: 10.sp, color: Colors.grey),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              CircleAvatar(
                radius: 12.r,
                backgroundImage: NetworkImage(delivery.userImage),
              ),
              SizedBox(width: 8.w),
              Text(
                delivery.userName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(width: 4.w),
              SvgPicture.asset(AppIcons.verifa, width: 14.w, height: 14.h),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRepublishTrips(bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildRepublishItem(
            'trip_completed'.tr,
            "Tunis \u2192 Paris",
            "23h ago",
            isDarkMode,
          ),
          Divider(
            height: 24.h,
            color: isDarkMode ? Colors.white10 : Colors.grey.shade100,
          ),
          _buildRepublishItem(
            'trip_completed'.tr,
            "Paris \u2192 Tunis",
            "1h ago",
            isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildRepublishItem(
    String title,
    String route,
    String time,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            size: 16.sp,
            color: isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                route,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
      ],
    );
  }
}
