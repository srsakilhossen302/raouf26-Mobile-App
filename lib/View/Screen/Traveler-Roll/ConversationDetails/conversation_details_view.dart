import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/ConversationDetails/conversation_details_controller.dart';
import '../../../../Utils/AppIcons/app_icons.dart';

class ConversationDetailsView extends GetView<ConversationDetailsController> {
  const ConversationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ConversationDetailsController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Conversation Details",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Profile Card
            _buildSectionCard(
              isDarkMode,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: NetworkImage(controller.transporterImage.value),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              controller.transporterName.value,
                              style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 4.w),
                            SvgPicture.asset(AppIcons.verifa, width: 14.w, height: 14.h),
                          ],
                        ),
                        Text(
                          controller.tripInfo.value,
                          style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            _sectionTitle("In This Conversation", isDarkMode),
            SizedBox(height: 12.h),
            _buildSectionCard(
              isDarkMode,
              child: Column(
                children: [
                  _conversationUserRow(controller.transporterName.value, "Transporter", controller.transporterImage.value, false),
                  Divider(height: 24.h, color: Colors.grey.shade200),
                  _conversationUserRow(controller.clientName.value, "Client", controller.clientImage.value, true),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            _sectionTitle("Conversation Actions", isDarkMode),
            SizedBox(height: 12.h),
            _buildSectionCard(
              isDarkMode,
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _actionRow(AppIcons.markUnread, "Mark as Unread", () => controller.onActionTap("Mark as Unread")),
                  _actionDivider(),
                  _actionRow(AppIcons.star, "Star Conversation", () => controller.onActionTap("Star Conversation")),
                  _actionDivider(),
                  _actionRow(AppIcons.archive, "Archive Conversation", () => controller.onActionTap("Archive Conversation")),
                  _actionDivider(),
                  _actionRow(AppIcons.mute, "Mute Conversation", () => controller.onActionTap("Mute Conversation")),
                  _actionDivider(),
                  _actionRow(AppIcons.printLabel, "Print Parcel Label", () => controller.onActionTap("Print Parcel Label")),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            _sectionTitle("Last Rating Received", isDarkMode),
            SizedBox(height: 12.h),
            _buildSectionCard(
              isDarkMode,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage: NetworkImage(controller.transporterImage.value),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.transporterName.value,
                          style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Tunis → Paris",
                          style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey),
                        ),
                        Row(
                          children: [
                            ...List.generate(5, (index) => Icon(Icons.star, color: Colors.orange, size: 14.sp)),
                            SizedBox(width: 4.w),
                            Text("4.8", style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            _sectionTitle("Support", isDarkMode),
            SizedBox(height: 12.h),
            _buildSectionCard(
              isDarkMode,
              child: _actionRow(AppIcons.helpCenter, "Visit the Help Center", () => controller.onActionTap("Help Center"), showArrow: true),
              padding: EdgeInsets.zero,
            ),

            SizedBox(height: 24.h),
            _sectionTitle("Privacy & Safety Notice", isDarkMode),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: const Color(0xFF4A80F0).withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info, color: const Color(0xFF4A80F0), size: 20.sp),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _noticeText("We may review messages to ensure safety, provide support, and improve our services. ", "Learn more"),
                            SizedBox(height: 12.h),
                            _noticeText("You can manage how your message data is processed, including for certain automated features. ", "Learn more"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, bool isDarkMode) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildSectionCard(bool isDarkMode, {required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }

  Widget _conversationUserRow(String name, String role, String imageUrl, bool isMe) {
    return Row(
      children: [
        CircleAvatar(radius: 20.r, backgroundImage: NetworkImage(imageUrl)),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w700)),
              Text(role, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey)),
            ],
          ),
        ),
        if (isMe)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(color: const Color(0xFF4A80F0).withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
            child: Text("Me", style: GoogleFonts.montserrat(fontSize: 10.sp, fontWeight: FontWeight.w600, color: const Color(0xFF4A80F0))),
          ),
      ],
    );
  }

  Widget _actionRow(String icon, String title, VoidCallback onTap, {bool showArrow = true}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8.r)),
              child: SvgPicture.asset(icon, width: 20.w, height: 20.h, colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn)),
            ),
            SizedBox(width: 16.w),
            Expanded(child: Text(title, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600))),
            if (showArrow) Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _actionDivider() {
    return Divider(height: 1, indent: 60.w, color: Colors.grey.shade100);
  }

  Widget _noticeText(String text, String link) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.black87, height: 1.4),
        children: [
          TextSpan(text: text),
          TextSpan(text: link, style: const TextStyle(color: Color(0xFF4A80F0), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
