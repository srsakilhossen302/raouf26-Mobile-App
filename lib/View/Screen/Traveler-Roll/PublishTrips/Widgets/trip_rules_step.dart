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
            "Set clear rules for senders and define your delivery conditions.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24.h),

          // Add a Rule Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                // Logic to add a rule
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
          SizedBox(height: 24.h),

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
                      controller.selectedWhatYouAccept.add(option["label"]);
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
