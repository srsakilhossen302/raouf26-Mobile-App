import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController(text: "Zain Malik");
  final TextEditingController _phoneController = TextEditingController(text: "+216 340-1641098");
  final TextEditingController _emailController = TextEditingController(text: "zainmalik02323@gmail.com");

  bool _googleLinked = true;
  bool _facebookLinked = true;

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
          'edit_profile'.tr,
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
            SizedBox(height: 20.h),
            // Profile Image Section
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white10 : Colors.grey[200],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: NetworkImage("https://i.pravatar.cc/150?u=a042581f4e29026704d"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFF4A80F0),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        AppIcons.camera,
                        width: 18.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Form Fields
            _buildTextField(
              label: 'user_name'.tr,
              controller: _nameController,
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 20.h),
            _buildTextField(
              label: 'phone_number'.tr,
              controller: _phoneController,
              isDarkMode: isDarkMode,
              keyboardType: TextInputType.phone,
              enabled: false,
            ),
            SizedBox(height: 20.h),
            _buildTextField(
              label: 'email'.tr,
              controller: _emailController,
              isDarkMode: isDarkMode,
              keyboardType: TextInputType.emailAddress,
              enabled: false,
            ),
            SizedBox(height: 32.h),

            // Linked Accounts Section
            Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'linked_accounts'.tr,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildLinkedAccountItem(
                    label: 'Google',
                    iconPath: AppIcons.google,
                    value: _googleLinked,
                    onChanged: (val) => setState(() => _googleLinked = val),
                    isDarkMode: isDarkMode,
                  ),
                  Divider(
                    height: 24.h,
                    color: isDarkMode ? Colors.white10 : Colors.grey[100],
                  ),
                  _buildLinkedAccountItem(
                    label: 'Facebook',
                    iconPath: AppIcons.facebook,
                    value: _facebookLinked,
                    onChanged: (val) => setState(() => _facebookLinked = val),
                    isDarkMode: isDarkMode,
                    isLast: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),

            // Save Button
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
                  'save'.tr,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool isDarkMode,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white70 : Colors.grey[700],
            ),
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            color: isDarkMode
                ? (enabled ? Colors.white : Colors.white38)
                : (enabled ? Colors.black : Colors.black38),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDarkMode
                ? (enabled ? const Color(0xFF1E1E1E) : Colors.black38)
                : (enabled ? const Color(0xFFF5F7FA) : const Color(0xFFE0E0E0)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            suffixIcon: !enabled
                ? Icon(
                    Icons.lock_outline,
                    size: 18.sp,
                    color: isDarkMode ? Colors.white24 : Colors.black26,
                  )
                : null,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
        ),
      ],
    );
  }

  Widget _buildLinkedAccountItem({
    required String label,
    required String iconPath,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDarkMode,
    bool isLast = false,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
            shape: BoxShape.circle,
          ),
          child: iconPath.endsWith('.svg')
              ? SvgPicture.asset(iconPath, width: 20.w)
              : Image.asset(iconPath, width: 20.w),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        Switch.adaptive(
          value: value,
          activeColor: const Color(0xFF4A80F0),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
