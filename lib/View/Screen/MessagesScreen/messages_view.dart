import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import 'package:raouf26mobileapp/View/Screen/MessagesScreen/messages_controller.dart';
import 'package:raouf26mobileapp/View/Screen/MessagesScreen/chat_view.dart';
import 'package:raouf26mobileapp/View/Screen/MessagesScreen/archive_view.dart';
import 'package:raouf26mobileapp/View/Widget/custom_bottom_nav_bar.dart';
import 'package:raouf26mobileapp/View/Widget/custom_transporter_bottom_nav_bar.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessagesController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Messages",
          style: GoogleFonts.montserrat(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            icon: Icon(
              Icons.settings_outlined,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            onSelected: (value) {
              if (value == 0) {
                Get.to(() => const ArchiveView());
              } else if (value == 1) {
                // Give Feedback
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.archive_outlined,
                      size: 20.sp,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "Archive",
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 20.sp,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "Give Feedback",
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF1E1E1E)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search ...",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                ),
              ),
            ),
          ),

          // Role Filters
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  _buildFilterTab(controller, "All", 0, isDarkMode),
                  SizedBox(width: 10.w),
                  _buildFilterTab(controller, "Traveler", 1, isDarkMode),
                  SizedBox(width: 10.w),
                  _buildFilterTab(controller, "Client", 2, isDarkMode),
                  SizedBox(width: 10.w),
                  _buildFilterTab(controller, "Transporter", 3, isDarkMode),
                ],
              ),
            ),
          ),

          // Message List
          Expanded(
            child: Obx(() {
              final messages = controller.filteredMessages;
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Slidable(
                    key: ValueKey(message['name']),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.4,
                      children: [
                        CustomSlidableAction(
                          onPressed: (context) =>
                              controller.archiveMessage(message),
                          backgroundColor: Colors.grey.shade100,
                          foregroundColor: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(12.r),
                          child: SvgPicture.asset(
                            AppIcons.achitacar,
                            width: 20.w,
                            height: 20.h,
                            colorFilter: ColorFilter.mode(
                              Colors.grey.shade700,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        CustomSlidableAction(
                          onPressed: (context) =>
                              controller.deleteMessage(message),
                          backgroundColor: Colors.red.shade50,
                          foregroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(12.r),
                          child: SvgPicture.asset(
                            AppIcons.deleteIcon,
                            width: 20.w,
                            height: 20.h,
                            colorFilter: const ColorFilter.mode(
                              Colors.red,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => Get.to(() => ChatView(userData: message)),
                      child: _buildMessageItem(message, isDarkMode),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () => controller.userRole.value == "Transporter"
            ? CustomTransporterBottomNavBar.buildFloatingActionButton()
            : CustomBottomNavBar.buildFloatingActionButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => controller.userRole.value == "Transporter"
            ? const CustomTransporterBottomNavBar(selectedIndex: 3)
            : const CustomBottomNavBar(selectedIndex: 3),
      ),
    );
  }

  Widget _buildFilterTab(
    MessagesController controller,
    String label,
    int index,
    bool isDarkMode,
  ) {
    return Obx(() {
      bool isSelected = controller.selectedTab.value == index;
      return GestureDetector(
        onTap: () => controller.onTabSelected(index),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDarkMode ? Colors.white : const Color(0xFF1A1A1A))
                : (isDarkMode ? Colors.transparent : Colors.white),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? (isDarkMode ? Colors.white : const Color(0xFF1A1A1A))
                  : Colors.grey.shade300,
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? (isDarkMode ? Colors.black : Colors.white)
                  : (isDarkMode ? Colors.white70 : Colors.grey.shade600),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildMessageItem(Map<String, dynamic> message, bool isDarkMode) {
    bool isSupport = message['isSupport'] ?? false;
    bool isUnread = message['isUnread'] ?? false;
    bool hasStatus = message['status'] != null && message['status'].isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Stack(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: isSupport
                    ? const Color(0xFF4A80F0)
                    : Colors.grey.shade200,
                backgroundImage: isSupport
                    ? null
                    : NetworkImage(message['image']),
                child: isSupport
                    ? Icon(
                        Icons.headset_mic_outlined,
                        color: Colors.white,
                        size: 24.sp,
                      )
                    : null,
              ),
              if (!isSupport && isUnread)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDarkMode
                            ? const Color(0xFF121212)
                            : Colors.white,
                        width: 2.w,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 15.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message['name'],
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        if (isUnread)
                          Container(
                            width: 8.w,
                            height: 8.w,
                            margin: EdgeInsets.only(right: 8.w),
                            decoration: const BoxDecoration(
                              color: Color(0xFF4A80F0),
                              shape: BoxShape.circle,
                            ),
                          ),
                        Text(
                          message['time'],
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                if (isSupport)
                  Text(
                    message['message'],
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
                  )
                else ...[
                  Row(
                    children: [
                      if (hasStatus) ...[
                        Container(
                          width: 4.w,
                          height: 4.w,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "${message['status']} ",
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      Text(
                        message['subtitle'],
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    message['message'],
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
