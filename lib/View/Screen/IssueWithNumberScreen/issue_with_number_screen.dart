import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../UpdateNumberScreen/update_number_screen.dart';

class IssueWithNumberScreen extends StatefulWidget {
  const IssueWithNumberScreen({super.key});

  @override
  State<IssueWithNumberScreen> createState() => _IssueWithNumberScreenState();
}

class _IssueWithNumberScreenState extends State<IssueWithNumberScreen> {
  String selectedIssue = "changed"; // changed, no_access

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
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
        title: Text(
          "Issue with number",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              "Trouble Signing In?",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "We'll help you recover access to your account quickly and securely.",
              style: TextStyle(
                fontSize: 16.sp,
                color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 32.h),
            _issueOption(
              title: "I changed my phone number",
              subtitle: "I changed my phone number",
              type: "changed",
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 16.h),
            _issueOption(
              title: "I no longer have access to this number",
              subtitle: "I no longer have access to this number",
              type: "no_access",
              isDarkMode: isDarkMode,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const UpdateNumberScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
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

  Widget _issueOption({
    required String title,
    required String subtitle,
    required String type,
    required bool isDarkMode,
  }) {
    bool isSelected = selectedIssue == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIssue = type;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF4A80F0) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDarkMode ? Colors.white54 : Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 20.r,
              width: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF4A80F0) : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        height: 10.r,
                        width: 10.r,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4A80F0),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
