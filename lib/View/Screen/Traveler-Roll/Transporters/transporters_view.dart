import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Transporters/transporters_controller.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Transporters/transporter_details_view.dart';
import 'package:raouf26mobileapp/View/Widget/custom_bottom_nav_bar.dart';
import 'package:raouf26mobileapp/utils/appicons/app_icons.dart';

class TransportersView extends GetView<TransportersController> {
  const TransportersView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TransportersController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : Colors.grey.shade50,
      floatingActionButton: CustomBottomNavBar.buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(
        selectedIndex: 2,
      ), // Index 2 for Search context
      body: Column(
        children: [
          // Custom Header
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 24.w), // Spacer for center alignment
                  Text(
                    "Transporters",
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showFilterBottomSheet(context, isDarkMode),
                    child: SvgPicture.asset(
                      AppIcons.filters,
                      width: 24.w,
                      height: 24.h,
                      colorFilter: ColorFilter.mode(
                        isDarkMode ? Colors.white : Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Search Bar
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Location...",
                  hintStyle: GoogleFonts.manrope(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey, size: 22.sp),
                ),
              ),
            ),
          ),

          // Filters
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: controller.filters
                  .map(
                    (filter) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: filter == controller.filters.last ? 0 : 8.w,
                        ),
                        child: Obx(
                          () => GestureDetector(
                            onTap: () => controller.setFilter(filter),
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: controller.selectedFilter.value == filter
                                    ? const Color(0xFF1A1A1A)
                                    : (isDarkMode
                                          ? Colors.grey.shade900
                                          : Colors.white),
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color:
                                      controller.selectedFilter.value == filter
                                      ? Colors.transparent
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  filter,
                                  style: GoogleFonts.manrope(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        controller.selectedFilter.value ==
                                            filter
                                        ? Colors.white
                                        : (isDarkMode
                                              ? Colors.white70
                                              : Colors.black87),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          SizedBox(height: 16.h),

          // Info Banner
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: const Color(0xFF4A80F0).withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: const Color(0xFF4A80F0), size: 18.sp),
                  SizedBox(width: 8.w),
                  Text(
                    "4 Transporters Found!",
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  //
                  // Spacer(),
                  // SvgPicture.asset(
                  //   AppIcons.location,
                  //   width: 20.w,
                  //   height: 20.h,
                  // ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Transporters List
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: controller.filteredTransporters.length,
                itemBuilder: (context, index) {
                  final transporter = controller.filteredTransporters[index];
                  return GestureDetector(
                    onTap: () => Get.to(
                      () => TransporterDetailsView(transporter: transporter),
                    ),
                    child: _transporterCard(transporter, isDarkMode),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transporterCard(Transporter transporter, bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage: NetworkImage(transporter.imageUrl),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          transporter.name,
                          style: GoogleFonts.manrope(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        SvgPicture.asset(
                          AppIcons.verifa,
                          width: 14.w,
                          height: 14.h,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 14.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "${transporter.rating} • ${transporter.totalTrips} Trips",
                          style: GoogleFonts.manrope(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (transporter.isBestMatch)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F1FF),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: const Color(0xFF4A80F0).withOpacity(0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4A80F0).withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.r),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4A80F0),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 10.sp,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        "Best Match",
                        style: GoogleFonts.manrope(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4A80F0),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    transporter.vehicleType,
                    style: GoogleFonts.manrope(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.black26 : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              children: [
                _routeRow(
                  Icons.near_me_outlined,
                  transporter.from,
                  transporter.fromDate,
                  transporter.fromTime,
                  isDarkMode,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 1,
                      height: 20.h,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                _routeRow(
                  Icons.location_on_outlined,
                  transporter.to,
                  transporter.toDate,
                  transporter.toTime,
                  isDarkMode,
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Price Per kg",
                    style: GoogleFonts.manrope(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    transporter.pricePerKg,
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Estimated Total",
                    style: GoogleFonts.manrope(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    transporter.estimatedTotal,
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            children: [
              Text(
                "Also traveling to ${transporter.alsoTravelingTo.join(', ')}",
                style: GoogleFonts.manrope(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _routeRow(
    IconData icon,
    String city,
    String date,
    String time,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 18.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: GoogleFonts.manrope(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                date,
                style: GoogleFonts.manrope(fontSize: 11.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: GoogleFonts.manrope(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 0.85.sh,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF121212) : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.all(20.r),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  "Filters",
                  style: GoogleFonts.manrope(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () => controller.resetFilters(),
                  child: Text(
                    "Clear all",
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF4A80F0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    _filterTitle("Who will carry your parcel?", isDarkMode),
                    Obx(
                      () => _checkboxRow(
                        "Travelers",
                        "(Best for documents)",
                        controller.isTravelerSelected.value,
                        (val) => controller.isTravelerSelected.value = val!,
                        isDarkMode,
                      ),
                    ),
                    Obx(
                      () => _checkboxRow(
                        "Transporters",
                        "(Suitable for larger packages)",
                        controller.isTransporterSelected.value,
                        (val) => controller.isTransporterSelected.value = val!,
                        isDarkMode,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _filterTitle("Currency", isDarkMode),
                    SizedBox(height: 12.h),
                    _currencyDropdown(isDarkMode),
                    SizedBox(height: 24.h),
                    _filterTitle("Travel Date", isDarkMode),
                    SizedBox(height: 12.h),
                    GestureDetector(
                      onTap: () => _showDatePicker(context, isDarkMode),
                      child: _datePickerField(isDarkMode),
                    ),
                    SizedBox(height: 24.h),
                    _filterTitle("Price Range", isDarkMode),
                    SizedBox(height: 12.h),
                    _priceRangeSlider(isDarkMode),
                    SizedBox(height: 24.h),
                    _filterTitle("Route Preferences", isDarkMode),
                    Obx(
                      () => _checkboxRow(
                        "Direct only",
                        "(no stops)",
                        controller.isDirectOnly.value,
                        (val) => controller.isDirectOnly.value = val!,
                        isDarkMode,
                      ),
                    ),
                    Obx(
                      () => _checkboxRow(
                        "Allow stops",
                        "",
                        controller.isAllowStops.value,
                        (val) => controller.isAllowStops.value = val!,
                        isDarkMode,
                      ),
                    ),
                    Obx(
                      () => _checkboxRow(
                        "Passing through other countries",
                        "",
                        controller.isPassingOtherCountries.value,
                        (val) =>
                            controller.isPassingOtherCountries.value = val!,
                        isDarkMode,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _filterTitle("Storage Preferences", isDarkMode),
                    Obx(
                      () => _checkboxRow(
                        "Requires storage before pickup",
                        "",
                        controller.isStorageRequired.value,
                        (val) => controller.isStorageRequired.value = val!,
                        isDarkMode,
                      ),
                    ),
                    Obx(
                      () => _checkboxRow(
                        "No storage needed",
                        "",
                        controller.isNoStorageNeeded.value,
                        (val) => controller.isNoStorageNeeded.value = val!,
                        isDarkMode,
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      controller.resetFilters();
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Reset",
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A80F0),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Apply",
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _filterTitle(String title, bool isDarkMode) {
    return Text(
      title,
      style: GoogleFonts.manrope(
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _checkboxRow(
    String title,
    String subtitle,
    bool value,
    Function(bool?) onChanged,
    bool isDarkMode,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF4A80F0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            SizedBox(width: 4.w),
            Text(
              subtitle,
              style: GoogleFonts.manrope(fontSize: 12.sp, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  Widget _currencyDropdown(bool isDarkMode) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          final List<Map<String, String>> currencies = [
            {"code": "TND", "name": "Tunisian Dinar", "flag": "🇹🇳"},
            {"code": "EUR", "name": "Euro", "flag": "🇪🇺"},
            {"code": "USD", "name": "US Dollar", "flag": "🇺🇸"},
            {"code": "GBP", "name": "British Pound", "flag": "🇬🇧"},
          ];

          Get.bottomSheet(
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Currency",
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ...currencies.map((currency) {
                    bool isSelected =
                        controller.selectedCurrency.value == currency["code"];
                    return ListTile(
                      onTap: () {
                        controller.selectedCurrency.value = currency["code"]!;
                        Get.back();
                      },
                      leading: Text(
                        currency["flag"]!,
                        style: TextStyle(fontSize: 24.sp),
                      ),
                      title: Text(
                        currency["name"]!,
                        style: GoogleFonts.manrope(
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      trailing: Text(
                        currency["code"]!,
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? const Color(0xFF4A80F0)
                              : Colors.grey,
                        ),
                      ),
                      selected: isSelected,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Text(
                controller.selectedCurrency.value == "EUR"
                    ? "🇪🇺"
                    : controller.selectedCurrency.value == "USD"
                    ? "🇺🇸"
                    : controller.selectedCurrency.value == "GBP"
                    ? "🇬🇧"
                    : "🇹🇳",
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(width: 12.w),
              Text(
                controller.selectedCurrency.value,
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context, bool isDarkMode) {
    DateTime focusedDay = controller.selectedDate.value ?? DateTime.now();
    DateTime? tempSelectedDay = controller.selectedDate.value;

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 24),
                    Text(
                      "Select a Date",
                      style: GoogleFonts.manrope(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.close,
                        color: isDarkMode ? Colors.white : Colors.black,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (day) =>
                      isSameDay(tempSelectedDay, day),
                  onDaySelected: (selectedDay, focusedDayUpdate) {
                    setState(() {
                      tempSelectedDay = selectedDay;
                      focusedDay = focusedDayUpdate;
                    });
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: const Color(0xFF4A80F0).withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFF4A80F0),
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: GoogleFonts.manrope(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    weekendTextStyle: GoogleFonts.manrope(
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                    outsideTextStyle: GoogleFonts.manrope(
                      color: isDarkMode ? Colors.white24 : Colors.grey.shade400,
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: GoogleFonts.manrope(
                      color: Colors.grey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    weekendStyle: GoogleFonts.manrope(
                      color: isDarkMode
                          ? Colors.redAccent.withOpacity(0.7)
                          : Colors.redAccent,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updateDate(tempSelectedDay ?? focusedDay);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A80F0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Confirm",
                        style: GoogleFonts.manrope(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  Widget _datePickerField(bool isDarkMode) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Text(
              controller.selectedDate.value == null
                  ? "Select Date"
                  : DateFormat(
                      'dd MMM, yyyy',
                    ).format(controller.selectedDate.value!),
              style: GoogleFonts.manrope(color: Colors.grey, fontSize: 14.sp),
            ),
            const Spacer(),
            Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRangeSlider(bool isDarkMode) {
    return Obx(
      () => Column(
        children: [
          RangeSlider(
            values: controller.priceRange.value,
            min: 0,
            max: 20,
            activeColor: const Color(0xFF4A80F0),
            inactiveColor: Colors.grey.shade200,
            onChanged: (values) => controller.priceRange.value = values,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${controller.priceRange.value.start.toInt()} TND/ kg",
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${controller.priceRange.value.end.toInt()} TND/ kg",
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
