import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/MessagesScreen/chat_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../Widgets/booking_request_card.dart';
import '../../Widgets/custom_reject_button.dart';

class ChatView extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ChatView({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
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
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    SvgPicture.asset(
                      AppIcons.verifa,
                      width: 16.w,
                      height: 16.h,
                    ),
                  ],
                ),
                Text(
                  "Online",
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onSelected: (value) {
              if (value == 'clear') {
                controller.messages.clear();
              } else if (value == 'report') {
                Get.snackbar("Report", "User reported successfully.");
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'report',
                child: Text('Report User'),
              ),
              const PopupMenuItem(
                value: 'block',
                child: Text('Block User'),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Text('Clear Chat'),
              ),
            ],
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

                    if (controller.status.value != BookingStatus.accepted &&
                        userData['isSupport'] != true)
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
              SafeArea(
                bottom: true,
                child: _buildMessageInput(context, controller, isDarkMode),
              ),
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
              style: GoogleFonts.manrope(
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: BookingRequestCard(
        userName: userData['name'] ?? "User",
        userImage: userData['image'] ?? "https://i.pravatar.cc/150",
        timeAgo: "2 hrs ago",
        status: controller.status.value == BookingStatus.pending
            ? "Pending"
            : (controller.status.value == BookingStatus.accepted
                ? "Accepted"
                : "Declined"),
        fromCity: data['from'] ?? "Tunisia",
        toCity: data['to'] ?? "France",
        fromDate: "20 Jan",
        toDate: "20 Jan",
        fromTime: "08:30 AM",
        toTime: "10:45 PM",
        packageSize: data['weight'] ?? "15kg",
        packageStatus: "Urgent",
        packagePhotos: const [
          'https://via.placeholder.com/100',
          'https://via.placeholder.com/100'
        ],
        totalPrice: data['price'] ?? "37.50 TND",
        onAccept: () => controller.acceptBooking(),
        onReject: () => _showRejectBottomSheet(controller, isDarkMode),
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
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                date,
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: GoogleFonts.manrope(
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
            style: GoogleFonts.manrope(fontSize: 14.sp, color: Colors.grey),
          ),
          Row(
            children: [
              if (statusColor != null) ...[
                Icon(Icons.access_time, size: 14.sp, color: statusColor),
                SizedBox(width: 4.w),
              ],
              Text(
                value,
                style: GoogleFonts.manrope(
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
              style: GoogleFonts.manrope(
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
                  style: GoogleFonts.manrope(
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
                    style: GoogleFonts.manrope(
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

  Widget _buildMessageInput(BuildContext context, ChatController controller, bool isDarkMode) {
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
          GestureDetector(
            onTap: () => _showAttachmentMenu(context, controller, isDarkMode),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.grey, size: 24.sp),
            ),
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
                controller: controller.messageTextController,
                onSubmitted: (val) {
                  controller.sendMessage(val);
                  controller.messageTextController.clear();
                },
                decoration: InputDecoration(
                  hintText: "Type a message ...",
                  hintStyle: GoogleFonts.manrope(
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
              controller.sendMessage(controller.messageTextController.text);
              controller.messageTextController.clear();
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
                    color: isDarkMode ? Colors.white24 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "Reject Booking Request",
                style: GoogleFonts.manrope(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Please tell the client why you're rejecting this booking request.",
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "Quick Replies",
                style: GoogleFonts.manrope(
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
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF4A80F0).withOpacity(0.05)
                            : (isDarkMode
                                ? Colors.white.withOpacity(0.02)
                                : Colors.white),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF4A80F0)
                              : (isDarkMode
                                  ? Colors.white10
                                  : Colors.grey.shade200),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Text(
                        reason,
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          color: isSelected
                              ? const Color(0xFF4A80F0)
                              : (isDarkMode ? Colors.white70 : Colors.black87),
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
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.05)
                      : const Color(0xFFF8F9FB),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  maxLines: 4,
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: "Type here ...",
                    hintStyle: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      color: Colors.grey.shade400,
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
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
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

  void _showAttachmentMenu(BuildContext context, ChatController controller, bool isDarkMode) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Send Attachment",
              style: GoogleFonts.manrope(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _attachmentOption(
                  icon: Icons.camera_alt_rounded,
                  label: "Camera",
                  color: Colors.blue,
                  onTap: () {
                    Get.back();
                    controller.pickImage(ImageSource.camera);
                  },
                  isDarkMode: isDarkMode,
                ),
                _attachmentOption(
                  icon: Icons.photo_library_rounded,
                  label: "Gallery",
                  color: Colors.purple,
                  onTap: () {
                    Get.back();
                    controller.pickImage(ImageSource.gallery);
                  },
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _attachmentOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
