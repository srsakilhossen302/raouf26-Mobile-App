import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRejectButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomRejectButton({
    super.key,
    required this.onPressed,
    this.text = "Reject",
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: isDarkMode 
            ? const Color(0xFF2D1616) // Deep dark red tint for dark mode
            : const Color(0xFFFFFAFA), // Light pink tint for light mode
        padding: EdgeInsets.symmetric(vertical: 12.h),
        side: BorderSide(
          color: isDarkMode 
              ? const Color(0xFF4A1A1A) 
              : const Color(0xFFFFEAEA),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFFF3B3B),
        ),
      ),
    );
  }
}
