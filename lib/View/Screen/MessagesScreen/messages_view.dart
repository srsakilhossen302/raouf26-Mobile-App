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
    controller.refreshRole(); // Refresh role on every build
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
          Obx(
            () => controller.userRole.value == "Transporter"
                ? IconButton(
                    onPressed: () => _showCreateDialog(context, isDarkMode),
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: isDarkMode ? Colors.white : Colors.black,
                      size: 24.sp,
                    ),
                  )
                : const SizedBox(),
          ),
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
                Get.snackbar(
                  "Give Feedback",
                  "Feedback feature is coming soon!",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.blueAccent,
                  colorText: Colors.white,
                );
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
                  Obx(
                    () => controller.userRole.value == "Transporter"
                        ? Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: GestureDetector(
                              onTap: () =>
                                  _showCreateDialog(context, isDarkMode),
                              child: Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4A80F0),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),

          // Message List
          Expanded(
            child: Obx(() {
              final messages = controller.filteredMessages;
              return ListView.builder(
                padding: EdgeInsets.zero,
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
                          borderRadius: BorderRadius.zero,
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
                        CustomSlidableAction(
                          onPressed: (context) =>
                              controller.deleteMessage(message),
                          backgroundColor: Colors.red.shade50,
                          foregroundColor: Colors.red,
                          borderRadius: BorderRadius.zero,
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
            ? FloatingActionButton(
                onPressed: () => _showCreateDialog(context, isDarkMode),
                backgroundColor: const Color(0xFF4A80F0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                elevation: 4,
                child: Icon(Icons.add, color: Colors.white, size: 28.sp),
              )
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

  void _showCreateDialog(BuildContext context, bool isDarkMode) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create channel / group",
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 24.h),
              _buildCreateOption(
                icon: Icons.people_outline,
                title: "Create Group",
                subtitle: "sender + receiver + transporter",
                isDarkMode: isDarkMode,
                onTap: () {
                  Get.back();
                  _showCreateSheet(context, "Group", isDarkMode);
                },
              ),
              SizedBox(height: 16.h),
              _buildCreateOption(
                icon: Icons.campaign_outlined,
                title: "Create Channel",
                subtitle: "trip updates, route posts",
                isDarkMode: isDarkMode,
                onTap: () {
                  Get.back();
                  _showCreateSheet(context, "Channel", isDarkMode);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDarkMode,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDarkMode ? Colors.white12 : Colors.grey.shade200,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: const Color(0xFF4A80F0).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF4A80F0), size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateSheet(BuildContext context, String type, bool isDarkMode) {
    final bool isGroup = type == "Group";
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descController = TextEditingController();

    if (isGroup) {
      nameController.text =
          "Tunis \u2192 Paris | 22 Jan"; // Auto-generated mockup
    }

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create $type",
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              _buildLabel("$type Name", isDarkMode),
              _buildTextField(nameController, "Enter name", isDarkMode),
              SizedBox(height: 16.h),
              _buildLabel(isGroup ? "Linked Trip" : "Linked Route", isDarkMode),
              _buildTextField(
                null,
                "Select trip",
                isDarkMode,
                isDropdown: true,
              ),
              if (isGroup) ...[
                SizedBox(height: 16.h),
                _buildLabel("Linked Parcel (Optional)", isDarkMode),
                _buildTextField(
                  null,
                  "Select parcel",
                  isDarkMode,
                  isDropdown: true,
                ),
              ],
              SizedBox(height: 16.h),
              _buildLabel(
                isGroup ? "Add Participants" : "Add Followers",
                isDarkMode,
              ),
              _buildTextField(null, "Add users", isDarkMode, isDropdown: true),
              if (!isGroup) ...[
                SizedBox(height: 16.h),
                _buildLabel("Description (Optional)", isDarkMode),
                _buildTextField(
                  descController,
                  "Type here...",
                  isDarkMode,
                  maxLines: 3,
                ),
              ],
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      "Success",
                      "$type created successfully!",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A80F0),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "Create $type",
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildLabel(String label, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController? controller,
    String hint,
    bool isDarkMode, {
    bool isDropdown = false,
    int maxLines = 1,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.white.withOpacity(0.05)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: isDropdown
          ? InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hint,
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  ],
                ),
              ),
            )
          : TextField(
              controller: controller,
              maxLines: maxLines,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              ),
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
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
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
