import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raouf26mobileapp/Utils/AppIcons/app_icons.dart';
import '../Controllers/publish_trip_flow_controller.dart';

class TripRulesStep extends StatelessWidget {
  final PublishTripFlowController controller;
  final bool isDarkMode;

  const TripRulesStep({
    super.key,
    required this.controller,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> acceptanceOptions = [
      {"label": "Documents", "icon": AppIcons.documentsIcon},
      {"label": "Fragile Items", "icon": AppIcons.fragileItemsIcon},
      {"label": "Food (sealed)", "icon": AppIcons.foodSealedIcon},
      {"label": "Electronics", "icon": AppIcons.electronicsIcon},
    ];

    final List<Map<String, String>> guidelines = [
      {
        "title": "Proper Packaging",
        "subtitle":
            "Ensure items are securely packed to prevent damage during transit.",
      },
      {
        "title": "Clear Item Description",
        "subtitle":
            "Ask senders to accurately describe contents before confirmation.",
      },
      {
        "title": "Size & Weight Limits",
        "subtitle": "Mention maximum size and weight you can carry.",
      },
      {
        "title": "Fragile Handling Policy",
        "subtitle":
            "Clarify whether you accept fragile items and under what conditions.",
      },
      {
        "title": "No Restricted Items",
        "subtitle": "Do not accept prohibited or illegal goods.",
      },
    ];

    final List<String> suggestedRules = [
      "Max 5kg per package",
      "Proper packaging required",
      "Fragile items at sender's risk",
      "Delivery within 24 hours",
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trip Rules & Details",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          Text(
            "Define what you accept and the rules senders should follow.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24.h),

          // Recommended Guidelines
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recommended Guidelines",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "These best practices help you avoid disputes and ensure smooth deliveries.",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16.h),
                ...guidelines.map(
                  (g) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: Container(
                            width: 4.w,
                            height: 4.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                g["title"]!,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                g["subtitle"]!,
                                style: GoogleFonts.plusJakartaSans(
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
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Suggested Rules
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Suggested Rules",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Tap to quickly add common trip rules.",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16.h),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: suggestedRules.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.withOpacity(0.2),
                    height: 24.h,
                  ),
                  itemBuilder: (context, index) {
                    final rule = suggestedRules[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            rule,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.sp,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!controller.rules.contains(rule)) {
                              controller.rules.add(rule);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Add Your Rule
          Text(
            "Add Your Rule",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: controller.addRuleController,
            maxLines: 3,
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: "Type here ...",
              hintStyle: GoogleFonts.plusJakartaSans(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
              filled: true,
              fillColor: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Add a Rule Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                if (controller.addRuleController.text.trim().isNotEmpty) {
                  controller.rules.add(
                    controller.addRuleController.text.trim(),
                  );
                  controller.addRuleController.clear();
                }
              },
              icon: const Icon(Icons.add, color: Colors.grey),
              label: Text(
                "Add a Rule",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Display Added Rules
          Obx(
            () => controller.rules.isEmpty
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Added Rules",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: controller.rules
                            .map(
                              (rule) => Chip(
                                label: Text(
                                  rule,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12.sp,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                backgroundColor: isDarkMode
                                    ? Colors.white10
                                    : const Color(0xFFF5F7FA),
                                deleteIcon: const Icon(Icons.close, size: 14),
                                onDeleted: () => controller.rules.remove(rule),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  side: BorderSide.none,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
          ),

          // What You Accept?
          Text(
            "What You Accept?",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: acceptanceOptions.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final option = acceptanceOptions[index];
              return Obx(() {
                final isSelected = controller.selectedWhatYouAccept.contains(
                  option["label"],
                );
                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      controller.selectedWhatYouAccept.remove(option["label"]);
                    } else {
                      if (controller.selectedWhatYouAccept.length < 3) {
                        controller.selectedWhatYouAccept.add(option["label"]);
                      } else {
                        Get.snackbar(
                          "Selection Limit",
                          "You can only select up to 3 items.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent.withOpacity(0.8),
                          colorText: Colors.white,
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.05)
                          : const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF4A80F0)
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          option["icon"],
                          colorFilter: ColorFilter.mode(
                            isSelected ? const Color(0xFF4A80F0) : Colors.grey,
                            BlendMode.srcIn,
                          ),
                          width: 20.w,
                          height: 20.w,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            option["label"],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF4A80F0)
                                  : Colors.grey.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 10.w,
                                    height: 10.w,
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
              });
            },
          ),
          SizedBox(height: 24.h),

          // Trip Description
          Text(
            "Trip Description",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: controller.tripDescriptionController,
            maxLines: 4,
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: "Add any important notes for senders ...",
              hintStyle: GoogleFonts.plusJakartaSans(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
              filled: true,
              fillColor: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
