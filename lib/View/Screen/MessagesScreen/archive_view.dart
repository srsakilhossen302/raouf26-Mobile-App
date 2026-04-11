import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/MessagesScreen/messages_controller.dart';

class ArchiveView extends StatelessWidget {
  const ArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MessagesController>();
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Archive",
          style: GoogleFonts.montserrat(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.archivedMessages.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 100.sp,
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 24.h),
                Text(
                  "No Archived Chats",
                  style: GoogleFonts.montserrat(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Archived chats will appear here.",
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemCount: controller.archivedMessages.length,
          itemBuilder: (context, index) {
            final message = controller.archivedMessages[index];
            return _buildArchiveItem(message, isDarkMode);
          },
        );
      }),
    );
  }

  Widget _buildArchiveItem(Map<String, dynamic> message, bool isDarkMode) {
    // Reusing logic from messages_view or creating a simple version
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundImage: NetworkImage(message['image']),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message['name'],
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  message['message'],
                  style: GoogleFonts.montserrat(
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
