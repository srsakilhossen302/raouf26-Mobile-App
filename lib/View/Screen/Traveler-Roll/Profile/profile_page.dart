import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import 'package:raouf26mobileapp/Utils/theme_controller.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/manage_account_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/edit_profile_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/account_safety_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/payment_method_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/saved_address_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/accessibility_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/account_verification_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/document_verification_page.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/trips_shipments_page.dart';

import '../../../../helper/shared_preference_helper.dart';
import '../../../Widget/custom_bottom_nav_bar.dart';
import '../../Transporter-Roll/Home/view/transporter_home_view.dart';
import '../PublishTrips/Views/transport_agreement_page.dart';
import '../../../Widget/custom_transporter_bottom_nav_bar.dart';
import '../Search/search_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder<String?>(
      future: SharedPreferenceHelper.getUserRole(),
      builder: (context, snapshot) {
        final currentRole = snapshot.data ?? "Traveler";
        final bool isTransporter = currentRole == "Transporter";

        return Scaffold(
          backgroundColor: isDarkMode
              ? const Color(0xFF121212)
              : const Color(0xFFF8F9FB),
          floatingActionButton: isTransporter
              ? FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: const Color(0xFF4A80F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 28.sp),
                )
              : CustomBottomNavBar.buildFloatingActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: isTransporter
              ? const CustomTransporterBottomNavBar(
                  selectedIndex: 0,
                ) // Profile index
              : const CustomBottomNavBar(selectedIndex: 4), // Profile index
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: () => Get.back(),
            ),
            centerTitle: true,
            title: Text(
              'profile'.tr,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                // User Info Card
                _buildProfileHeader(isDarkMode),
                SizedBox(height: 24.h),

                // App Preferences
                _buildSection(
                  title: 'app_preferences'.tr,
                  isDarkMode: isDarkMode,
                  items: [
                    _buildMenuItem(
                      'account_safety'.tr,
                      "assets/icons/Account Safety.svg",
                      isDarkMode,
                      onTap: () => Get.to(() => const AccountSafetyPage()),
                    ),
                    _buildMenuItem(
                      'payments_payouts'.tr,
                      "assets/icons/Payments & Payouts.svg",
                      isDarkMode,
                      onTap: () => Get.to(() => const PaymentMethodPage()),
                    ),
                    _buildMenuItem(
                      'saved_address'.tr,
                      "assets/icons/Saved Address.svg",
                      isDarkMode,
                      onTap: () => Get.to(() => const SavedAddressPage()),
                    ),
                    _buildMenuItem(
                      'accessibility'.tr,
                      "assets/icons/Accessibility.svg",
                      isDarkMode,
                      onTap: () => Get.to(() => const AccessibilityPage()),
                    ),
                    // _buildThemeToggle(isDarkMode),
                  ],
                ),
                SizedBox(height: 24.h),

                // Verification
                _buildSection(
                  title: 'verification'.tr,
                  isDarkMode: isDarkMode,
                  items: [
                    _buildMenuItem(
                      'account_verification'.tr,
                      "assets/icons/Account Verification.svg",
                      isDarkMode,
                      onTap: () =>
                          Get.to(() => const AccountVerificationPage()),
                    ),
                    _buildMenuItem(
                      'documents_verification'.tr,
                      "assets/icons/Documents-icons.svg",
                      isDarkMode,
                      onTap: () =>
                          Get.to(() => const DocumentVerificationPage()),
                    ),
                    _buildMenuItem(
                      'transport_agreement'.tr,
                      "assets/icons/Transport Agreement.svg",
                      isDarkMode,
                      onTap: () => Get.to(
                        () => TransportAgreementPage(isDarkMode: isDarkMode),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Activities
                _buildSection(
                  title: 'activities'.tr,
                  isDarkMode: isDarkMode,
                  items: [
                    _buildMenuItem(
                      'trips_shipments'.tr,
                      "assets/icons/Trips & Shipments.svg",
                      isDarkMode,
                      onTap: () => Get.to(() => const TripsShipmentsPage()),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Others
                _buildSection(
                  title: 'others'.tr,
                  isDarkMode: isDarkMode,
                  items: [
                    _buildMenuItem(
                      'report_an_issue'.tr,
                      "assets/icons/Report an Issue.svg",
                      isDarkMode,
                      onTap: () =>
                          _showReportIssueBottomSheet(context, isDarkMode),
                    ),
                    _buildMenuItem(
                      'help_center'.tr,
                      "assets/icons/Help Center.svg",
                      isDarkMode,
                    ),
                    _buildMenuItem(
                      'terms_of_service'.tr,
                      "assets/icons/Terms of Service.svg",
                      isDarkMode,
                    ),
                    _buildMenuItem(
                      'privacy_policy'.tr,
                      "assets/icons/Privacy Policy.svg",
                      isDarkMode,
                    ),
                    _buildMenuItem(
                      'rate_sendit_app'.tr,
                      "assets/icons/Rate Sendit App.svg",
                      isDarkMode,
                    ),
                    _buildMenuItem(
                      'manage_account'.tr,
                      "assets/icons/Manage Account.svg",
                      isDarkMode,
                      onTap: () => Get.to(() => const ManageAccountPage()),
                    ),
                    _buildMenuItem(
                      'log_out'.tr,
                      "assets/icons/Log Out.svg",
                      isDarkMode,
                      isLast: true,
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // Role Switch Button
                FutureBuilder<String?>(
                  future: SharedPreferenceHelper.getUserRole(),
                  builder: (context, snapshot) {
                    final currentRole = snapshot.data ?? "Traveler";
                    final bool isTraveler = currentRole == "Traveler";

                    return ElevatedButton.icon(
                      onPressed: () async {
                        if (isTraveler) {
                          await SharedPreferenceHelper.saveUserRole(
                            "Transporter",
                          );
                          Get.offAll(() => const TransporterHomeScreen());
                        } else {
                          await SharedPreferenceHelper.saveUserRole("Traveler");
                          Get.offAll(() => const SearchScreen());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A80F0),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 14.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        elevation: 0,
                      ),
                      icon: SvgPicture.asset(
                        isTraveler
                            ? "assets/icons/Switch to Transporter.svg"
                            : "assets/icons/Switch to Transporter.svg", // Using same or different icon
                        width: 20.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: Text(
                        isTraveler
                            ? 'switch_to_transporter'.tr
                            : 'Switch to Traveler',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.h),
                Text(
                  "${'version'.tr} 1.1.0",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://i.pravatar.cc/150?u=a042581f4e29026704d",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Zain Malik",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.verified, color: Colors.blue, size: 16.sp),
                      ],
                    ),
                    Text(
                      "zainmalik02323@gmail.com",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        color: isDarkMode ? Colors.white70 : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(() => const EditProfilePage()),
                child: SvgPicture.asset(
                  "assets/icons/Edit-icons.svg",
                  width: 20.w,
                  colorFilter: ColorFilter.mode(
                    isDarkMode ? Colors.white : Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(
            color: isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.1),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                "24",
                'total_trips'.tr,
                "assets/icons/flight.svg",
                isDarkMode,
              ),
              _buildStatItem(
                "4.8",
                'rating'.tr,
                "assets/icons/Rating.svg",
                isDarkMode,
              ),
              _buildStatItem(
                "98%",
                'on_time'.tr,
                "assets/icons/On-Time.svg",
                isDarkMode,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String value,
    String label,
    String iconPath,
    bool isDarkMode,
  ) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.white.withOpacity(0.05)
                : const Color(0xFFF5F7FA),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            iconPath,
            width: 20.w,
            colorFilter: ColorFilter.mode(
              isDarkMode ? Colors.white : Colors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11.sp,
            color: isDarkMode ? Colors.white70 : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> items,
    required bool isDarkMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              if (!isDarkMode)
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    String title,
    String iconPath,
    bool isDarkMode, {
    bool isLast = false,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          leading: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : const Color(0xFFF5F7FA),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              iconPath,
              width: 18.w,
              colorFilter: ColorFilter.mode(
                isDarkMode ? Colors.white : Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: isDarkMode ? Colors.white38 : Colors.grey,
            size: 20.sp,
          ),
          onTap: onTap ?? () {},
        ),
        if (!isLast)
          Divider(
            indent: 60.w,
            endIndent: 16.w,
            height: 1,
            color: isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.1),
          ),
      ],
    );
  }
}

void _showReportIssueBottomSheet(BuildContext context, bool isDarkMode) {
  Get.bottomSheet(
    StatefulBuilder(
      builder: (context, setState) {
        String selectedCategory = "App Issue";
        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 48), // Spacer for centering
                    Text(
                      'Report Issue',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Icon(Icons.error_rounded, color: Colors.red, size: 48.sp),
                SizedBox(height: 24.h),
                Text(
                  'Please include the following details in your report',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                _buildTipItem("Select the issue category", isDarkMode),
                _buildTipItem(
                  "Provide detailed problem description",
                  isDarkMode,
                ),
                SizedBox(height: 24.h),
                Text(
                  'What is this Report About?',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: [
                    _buildCategoryChip(
                      "App Issue",
                      selectedCategory == "App Issue",
                      isDarkMode,
                      (val) => setState(() => selectedCategory = val),
                    ),
                    _buildCategoryChip(
                      "Account",
                      selectedCategory == "Account",
                      isDarkMode,
                      (val) => setState(() => selectedCategory = val),
                    ),
                    _buildCategoryChip(
                      "Payment",
                      selectedCategory == "Payment",
                      isDarkMode,
                      (val) => setState(() => selectedCategory = val),
                    ),
                    _buildCategoryChip(
                      "Transporter Issue",
                      selectedCategory == "Transporter Issue",
                      isDarkMode,
                      (val) => setState(() => selectedCategory = val),
                    ),
                    _buildCategoryChip(
                      "Others",
                      selectedCategory == "Others",
                      isDarkMode,
                      (val) => setState(() => selectedCategory = val),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  'Describe Issue',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  maxLines: 4,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: "Type here ...",
                    hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : const Color(0xFFF8F9FB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Add Attachment (Optional)',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : const Color(0xFFF8F9FB),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.description_outlined,
                        color: Colors.grey,
                        size: 32.sp,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Add Image or Document",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A80F0),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Submit",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    ),
    isScrollControlled: true,
  );
}

Widget _buildTipItem(String tip, bool isDarkMode) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Row(
      children: [
        Icon(Icons.circle, size: 4.sp, color: Colors.grey),
        SizedBox(width: 8.w),
        Text(
          tip,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCategoryChip(
  String label,
  bool isSelected,
  bool isDarkMode,
  Function(String) onTap,
) {
  return InkWell(
    onTap: () => onTap(label),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF4A80F0)
            : (isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: isSelected
              ? Colors.white
              : (isDarkMode ? Colors.white70 : Colors.black87),
        ),
      ),
    ),
  );
}

Widget _buildThemeToggle(bool isDarkMode) {
  final themeController = ThemeController.instance;
  return Column(
    children: [
      Divider(
        indent: 60.w,
        endIndent: 16.w,
        height: 1,
        color: isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.1),
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.white.withOpacity(0.05)
                : const Color(0xFFF5F7FA),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_rounded,
            size: 18.sp,
            color: isDarkMode ? Colors.white : Colors.orange,
          ),
        ),
        title: Text(
          'dark_mode'.tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        trailing: Obx(
          () => Switch.adaptive(
            value: themeController.isDarkMode.value,
            activeColor: const Color(0xFF4A80F0),
            onChanged: (value) {
              themeController.toggleTheme();
            },
          ),
        ),
      ),
    ],
  );
}
