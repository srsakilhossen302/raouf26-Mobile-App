import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Profile/add_address_page.dart';

class SavedAddressPage extends StatefulWidget {
  const SavedAddressPage({super.key});

  @override
  State<SavedAddressPage> createState() => _SavedAddressPageState();
}

class _SavedAddressPageState extends State<SavedAddressPage> {
  int selectedTabIndex = 0; // 0 for Personal, 1 for Business

  final List<Map<String, String>> personalAddresses = [
    {
      'title': 'Foyer Babel',
      'address': '20, Aryanah, Ariana, Tunisia',
    },
    {
      'title': 'Home',
      'address': '40, Sidi Bu Jafar, Sousse, Tunisia',
    },
  ];

  final List<Map<String, String>> businessAddresses = [];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FB),
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
          'saved_address_title'.tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          // Custom Tab Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  _buildTabItem('personal'.tr, 0, isDarkMode),
                  _buildTabItem('business'.tr, 1, isDarkMode),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: selectedTabIndex == 0
                ? _buildAddressList(personalAddresses, isDarkMode)
                : _buildBusinessEmptyState(isDarkMode),
          ),
          // Bottom Button
          Padding(
            padding: EdgeInsets.all(24.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Get.to(() => const AddAddressPage()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                icon: Icon(Icons.add, color: Colors.white, size: 20.sp),
                label: Text(
                  'add_new_address'.tr,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index, bool isDarkMode) {
    bool isSelected = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTabIndex = index),
        child: Container(
          margin: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4A80F0) : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : (isDarkMode ? Colors.white70 : Colors.grey[600]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressList(List<Map<String, String>> addresses, bool isDarkMode) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final item = addresses[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              if (!isDarkMode)
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 20.sp,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item['address']!,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              _buildOptionsMenu(isDarkMode),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionsMenu(bool isDarkMode) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert_rounded,
        color: isDarkMode ? Colors.white38 : Colors.grey[400],
        size: 20.sp,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      onSelected: (value) {
        // Handle options
      },
      itemBuilder: (BuildContext context) => [
        _buildPopupItem('edit'.tr, Icons.edit_outlined, isDarkMode),
        _buildPopupItem('share'.tr, Icons.share_outlined, isDarkMode),
        _buildPopupItem('delete'.tr, Icons.delete_outline_rounded, isDarkMode, isDelete: true),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupItem(String title, IconData icon, bool isDarkMode, {bool isDelete = false}) {
    return PopupMenuItem<String>(
      value: title,
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: isDelete ? Colors.red : (isDarkMode ? Colors.white70 : Colors.black87)),
          SizedBox(width: 12.w),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isDelete ? Colors.red : (isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessEmptyState(bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_outline_rounded,
            size: 80.sp,
            color: isDarkMode ? Colors.white10 : Colors.grey[200],
          ),
          SizedBox(height: 24.h),
          Text(
            'no_business_address_yet'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'no_business_address_desc'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
