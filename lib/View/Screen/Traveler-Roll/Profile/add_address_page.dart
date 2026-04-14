import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  int selectedAddressType = 0; // 0 for Personal, 1 for Business

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
          'add_new_address'.tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'address_type'.tr,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            _buildTypeSelection(isDarkMode),
            SizedBox(height: 32.h),
            Text(
              'address'.tr,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            _buildAddressInput(isDarkMode),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'save_address'.tr,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
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
  }

  Widget _buildTypeSelection(bool isDarkMode) {
    return Column(
      children: [
        _buildTypeItem('personal'.tr, Icons.person_outline_rounded, 0, isDarkMode),
        SizedBox(height: 12.h),
        _buildTypeItem('business'.tr, Icons.business_outlined, 1, isDarkMode),
      ],
    );
  }

  Widget _buildTypeItem(String title, IconData icon, int index, bool isDarkMode) {
    bool isSelected = selectedAddressType == index;
    return GestureDetector(
      onTap: () => setState(() => selectedAddressType = index),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF4A80F0) : (isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.1)),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? const Color(0xFF4A80F0) : (isDarkMode ? Colors.white38 : Colors.grey[400]),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressInput(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.1),
        ),
      ),
      child: TextField(
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14.sp,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'enter_address'.tr,
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            color: isDarkMode ? Colors.white30 : Colors.grey[400],
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.w),
            child: Icon(
              Icons.location_on_outlined,
              color: isDarkMode ? Colors.white38 : Colors.grey[400],
            ),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.all(12.w),
            child: Icon(
              Icons.map_outlined,
              color: const Color(0xFF4A80F0),
            ),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        ),
      ),
    );
  }
}
