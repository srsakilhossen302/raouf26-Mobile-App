import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/MessagesScreen/chat_controller.dart';
import '../../../../Utils/AppIcons/app_icons.dart';

class ChatView extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ChatView({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    // Delete existing controller to ensure fresh state for new user
    if (Get.isRegistered<ChatController>()) {
      Get.delete<ChatController>();
    }
    final controller = Get.put(ChatController());
    controller.setUserData(userData);
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
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: NetworkImage(userData['image']),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.w),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      userData['name'],
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.check_circle, color: Colors.blue, size: 16.sp),
                  ],
                ),
                Text(
                  "Online",
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    _buildCommunicationWarning(isDarkMode),

                    if (controller.status.value != BookingStatus.accepted)
                      _buildBookingRequestCard(controller, isDarkMode),

                    if (controller.status.value == BookingStatus.accepted)
                      _buildChatInterface(controller, isDarkMode),

                    if (controller.status.value == BookingStatus.pending)
                      _buildInfoBox(isDarkMode),
                  ],
                ),
              ),
            ),
            if (controller.status.value == BookingStatus.accepted)
              _buildMessageInput(controller, isDarkMode),
          ],
        );
      }),
    );
  }

  Widget _buildCommunicationWarning(bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              "Keep communication inside the app for better protection and support. Sharing personal contact info is not allowed.",
              style: GoogleFonts.montserrat(
                fontSize: 11.sp,
                color: isDarkMode ? Colors.white70 : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingRequestCard(ChatController controller, bool isDarkMode) {
    final data = controller.userData;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Booking Request",
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      "Urgent",
                      style: GoogleFonts.montserrat(
                        fontSize: 10.sp,
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Icon(Icons.edit_outlined, size: 20.sp, color: Colors.grey),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            "Route",
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          _buildRouteItem(
            Icons.near_me_outlined,
            data['from'] ?? "Tunisia",
            "20 Jan",
            "08:30 AM",
            isDarkMode,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              "⋮",
              style: TextStyle(color: Colors.grey, fontSize: 20.sp),
            ),
          ),
          _buildRouteItem(
            Icons.location_on_outlined,
            data['to'] ?? "France",
            "20 Jan",
            "10:45 PM",
            isDarkMode,
          ),

          Divider(height: 32.h),

          Text(
            "Package Summary",
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          _buildSummaryRow(
            "Package Weight",
            data['weight'] ?? "15kg",
            isDarkMode,
          ),
          _buildSummaryRow(
            "Delivery Time",
            "Jan 29, 2026 – Jan 31, 2026",
            isDarkMode,
          ),

          SizedBox(height: 12.h),
          Text(
            "Package Photos",
            style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              _buildPhoto('https://via.placeholder.com/100'),
              SizedBox(width: 8.w),
              _buildPhoto('https://via.placeholder.com/100'),
            ],
          ),

          SizedBox(height: 20.h),
          _buildSummaryRow(
            "Status",
            "Waiting Response",
            isDarkMode,
            statusColor: Colors.blue,
          ),
          _buildSummaryRow(
            "Total Estimate",
            data['price'] ?? "37.50 TND",
            isDarkMode,
            valueFontWeight: FontWeight.w700,
          ),

          if (controller.status.value == BookingStatus.pending) ...[
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        _showRejectBottomSheet(controller, isDarkMode),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Reject",
                      style: GoogleFonts.montserrat(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.acceptBooking(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A80F0),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Accept",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRouteItem(
    IconData icon,
    String city,
    String date,
    String time,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16.sp, color: Colors.grey),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                date,
                style: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value,
    bool isDarkMode, {
    Color? statusColor,
    FontWeight? valueFontWeight,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.grey),
          ),
          Row(
            children: [
              if (statusColor != null) ...[
                Icon(Icons.access_time, size: 14.sp, color: statusColor),
                SizedBox(width: 4.w),
              ],
              Text(
                value,
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color:
                      statusColor ?? (isDarkMode ? Colors.white : Colors.black),
                  fontWeight: valueFontWeight ?? FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhoto(String url) {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildInfoBox(bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF4A80F0).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: const Color(0xFF4A80F0), size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              "The conversation will open once the transporter accepts your delivery request.",
              style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: const Color(0xFF4A80F0),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatInterface(ChatController controller, bool isDarkMode) {
    return Column(
      children: controller.messages.map((msg) {
        bool isMe = msg['isMe'];
        return Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 16.h, bottom: 4.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                constraints: BoxConstraints(maxWidth: 0.7.sw),
                decoration: BoxDecoration(
                  color: isMe
                      ? const Color(0xFF4A80F0)
                      : (isDarkMode
                            ? Colors.grey.shade800
                            : Colors.grey.shade100),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                    bottomLeft: isMe ? Radius.circular(16.r) : Radius.zero,
                    bottomRight: isMe ? Radius.zero : Radius.circular(16.r),
                  ),
                ),
                child: Text(
                  msg['text'],
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    color: isMe
                        ? Colors.white
                        : (isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    msg['time'],
                    style: GoogleFonts.montserrat(
                      fontSize: 10.sp,
                      color: Colors.grey,
                    ),
                  ),
                  if (isMe) ...[
                    SizedBox(width: 4.w),
                    Icon(Icons.done_all, size: 14.sp, color: Colors.blue),
                  ],
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMessageInput(ChatController controller, bool isDarkMode) {
    final TextEditingController textController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.grey, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: "Type a message ...",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {
              controller.sendMessage(textController.text);
              textController.clear();
            },
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: const BoxDecoration(
                color: Color(0xFF4A80F0),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_upward, color: Colors.white, size: 24.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _showRejectBottomSheet(ChatController controller, bool isDarkMode) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "Reject Booking Request",
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Please tell the client why you're rejecting this booking request.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "Quick Replies",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              ...controller.quickReasons.map((reason) {
                return Obx(() {
                  bool isSelected = controller.selectedReason.value == reason;
                  return GestureDetector(
                    onTap: () => controller.selectReason(reason),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF4A80F0).withOpacity(0.05)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF4A80F0)
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Text(
                        reason,
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: isSelected
                              ? const Color(0xFF4A80F0)
                              : (isDarkMode ? Colors.white : Colors.black),
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                });
              }).toList(),
              SizedBox(height: 24.h),
              Text(
                "Enter Your Reason",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.grey.shade800
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Type here ...",
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.rejectBooking();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A80F0),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Confirm Rejection",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
