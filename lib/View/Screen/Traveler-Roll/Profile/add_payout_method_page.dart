import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';

class AddPayoutMethodPage extends StatefulWidget {
  const AddPayoutMethodPage({super.key});

  @override
  State<AddPayoutMethodPage> createState() => _AddPayoutMethodPageState();
}

class _AddPayoutMethodPageState extends State<AddPayoutMethodPage> {
  String selectedMethod = 'Bank Account';
  bool isPrimary = true;

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
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'Add Payout Method',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.help_outline,
              color: isDarkMode ? Colors.white : Colors.black54,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            
            // Method Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMethodSelectorCard(
                  title: 'Bank Account',
                  icon: Icons.account_balance_outlined,
                  isSelected: selectedMethod == 'Bank Account',
                  onTap: () => setState(() => selectedMethod = 'Bank Account'),
                  isDarkMode: isDarkMode,
                ),
                _buildMethodSelectorCard(
                  title: 'PayPal',
                  svgIcon: AppIcons.payPal,
                  isSelected: selectedMethod == 'PayPal',
                  onTap: () => setState(() => selectedMethod = 'PayPal'),
                  isDarkMode: isDarkMode,
                ),
                _buildMethodSelectorCard(
                  title: 'Google Pay',
                  svgIcon: AppIcons.googlePay,
                  isSelected: selectedMethod == 'Google Pay',
                  onTap: () => setState(() => selectedMethod = 'Google Pay'),
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
            
            SizedBox(height: 24.h),
            
            // Form Container
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
              ),
              child: Column(
                children: [
                  _buildInputField(
                    label: 'Account Holder Name',
                    hint: 'Enter account holder name',
                    icon: Icons.person_outline,
                    isDarkMode: isDarkMode,
                  ),
                  SizedBox(height: 16.h),
                  _buildInputField(
                    label: 'Bank Name',
                    hint: 'Enter bank name',
                    icon: Icons.account_balance_outlined,
                    isDarkMode: isDarkMode,
                  ),
                  SizedBox(height: 16.h),
                  _buildInputField(
                    label: 'IBAN / Account Number',
                    hint: 'Enter IBAN or account number',
                    icon: Icons.credit_card_outlined,
                    isDarkMode: isDarkMode,
                  ),
                  SizedBox(height: 16.h),
                  _buildInputField(
                    label: 'SWIFT / BIC',
                    hint: 'Enter SWIFT or BIC code',
                    icon: Icons.language_outlined,
                    isDarkMode: isDarkMode,
                  ),
                  SizedBox(height: 16.h),
                  _buildDropdownField(
                    label: 'Country',
                    hint: 'Select country',
                    icon: Icons.outlined_flag,
                    isDarkMode: isDarkMode,
                  ),
                  SizedBox(height: 16.h),
                  _buildDropdownField(
                    label: 'Currency',
                    hint: 'Select currency',
                    icon: Icons.monetization_on_outlined,
                    isDarkMode: isDarkMode,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Primary Method Checkbox
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: isPrimary,
                    onChanged: (val) => setState(() => isPrimary = val!),
                    activeColor: const Color(0xFF0066FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Set as primary payout method',
                          style: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          'This will be your default payout method',
                          style: GoogleFonts.manrope(
                            fontSize: 12.sp,
                            color: isDarkMode ? Colors.white38 : Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 32.h),
            
            // Save Button
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                minimumSize: Size(double.infinity, 56.h),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline_rounded, size: 20.sp),
                  SizedBox(width: 10.w),
                  Text(
                    'Save Payout Method',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodSelectorCard({
    required String title,
    IconData? icon,
    String? svgIcon,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 108.w,
        height: 110.h,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF0066FF) : (isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF0066FF).withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0066FF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 10.sp),
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.h,
                  width: 65.w,
                  child: svgIcon != null
                      ? SvgPicture.asset(
                          svgIcon,
                          fit: BoxFit.contain,
                        )
                      : Icon(
                          icon,
                          color: isSelected ? const Color(0xFF0066FF) : Colors.black26,
                          size: 32.sp,
                        ),
                ),
                SizedBox(height: 12.h),
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? const Color(0xFF0066FF) : (isDarkMode ? Colors.white38 : Colors.black45),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    required bool isDarkMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          style: GoogleFonts.manrope(fontSize: 14.sp, color: isDarkMode ? Colors.white : Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.manrope(fontSize: 14.sp, color: isDarkMode ? Colors.white24 : Colors.black26),
            prefixIcon: Icon(icon, color: isDarkMode ? Colors.white38 : Colors.black26, size: 20.sp),
            filled: true,
            fillColor: isDarkMode ? const Color(0xFF2C2C2E) : Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF0066FF)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required bool isDarkMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF2C2C2E) : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: isDarkMode ? Colors.white10 : const Color(0xFFEEEEEE)),
          ),
          child: Row(
            children: [
              Icon(icon, color: isDarkMode ? Colors.white38 : Colors.black26, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  hint,
                  style: GoogleFonts.manrope(fontSize: 14.sp, color: isDarkMode ? Colors.white24 : Colors.black26),
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: isDarkMode ? Colors.white38 : Colors.black26, size: 20.sp),
            ],
          ),
        ),
      ],
    );
  }
}
