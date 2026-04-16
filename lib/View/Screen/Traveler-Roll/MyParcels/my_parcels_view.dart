import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../Widget/custom_bottom_nav_bar.dart';
import 'my_parcels_controller.dart';

class MyParcelsScreen extends GetView<MyParcelsController> {
  const MyParcelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyParcelsController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF9FAFB),
      floatingActionButton: CustomBottomNavBar.buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Parcels",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search ...",
                hintStyle: GoogleFonts.montserrat(
                  color: isDarkMode ? Colors.white38 : Colors.grey,
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.sp),
                filled: true,
                fillColor: isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),

          // Filters
          SizedBox(
            height: 45.h,
            child: Obx(() {
              final selectedIndex = controller.selectedFilter.value;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: controller.filters.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => controller.updateFilter(index),
                    child: Container(
                      margin: EdgeInsets.only(right: 12.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDarkMode
                                  ? Colors.white10
                                  : const Color(0xFF1A1A1A))
                            : (isDarkMode ? Colors.transparent : Colors.white),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : (isDarkMode
                                    ? Colors.white10
                                    : Colors.grey.shade300),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          controller.filters[index],
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : (isDarkMode
                                      ? Colors.white70
                                      : Colors.grey.shade600),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          SizedBox(height: 20.h),

          // Parcel List
          Expanded(
            child: Obx(
              () => ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: controller.filteredParcels.length,
                separatorBuilder: (context, index) => SizedBox(height: 20.h),
                itemBuilder: (context, index) {
                  final parcel = controller.filteredParcels[index];
                  return CustomParcelCard(
                    name: parcel['name'],
                    date: parcel['date'],
                    status: parcel['status'],
                    statusStep: parcel['statusStep'],
                    from: parcel['from'],
                    to: parcel['to'],
                    price: parcel['price'],
                    total: parcel['total'],
                    isDarkMode: isDarkMode,
                    isDelivered: parcel['isDelivered'],
                    isCancelled: parcel['isCancelled'] ?? false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class CustomParcelCard extends StatelessWidget {
  final String name;
  final String date;
  final String status;
  final int statusStep;
  final String from;
  final String to;
  final String price;
  final String total;
  final bool isDarkMode;
  final bool isDelivered;
  final bool isCancelled;

  const CustomParcelCard({
    super.key,
    required this.name,
    required this.date,
    required this.status,
    required this.statusStep,
    required this.from,
    required this.to,
    required this.price,
    required this.total,
    required this.isDarkMode,
    this.isDelivered = false,
    this.isCancelled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header: Avatar, Name, Status
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: const NetworkImage(
                  "https://i.pravatar.cc/150?u=a042581f4e29026704d",
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        SvgPicture.asset(
                          "assets/icons/verifa-icon.svg",
                          width: 14.sp,
                          height: 14.sp,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF4A80F0),
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isCancelled
                      ? const Color(0xFFFEE2E2)
                      : isDelivered
                          ? const Color(0xFFE6F7ED)
                          : const Color(0xFFE8EFFF),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.montserrat(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: isCancelled
                        ? const Color(0xFFEF4444)
                        : isDelivered
                            ? const Color(0xFF22C55E)
                            : const Color(0xFF4A80F0),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Status Tracker
          if (!isDelivered && !isCancelled) ...[
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _statusLabel("Booked", isDarkMode, isActive: 0 <= statusStep),
                      _statusLabel("Picked Up", isDarkMode, isActive: 1 <= statusStep),
                      _statusLabel("In Transit", isDarkMode, isActive: 2 <= statusStep),
                      _statusLabel("Delivered", isDarkMode, isActive: 3 <= statusStep),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  _buildProgressLine(statusStep, isDarkMode),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],

          // Route Info
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white10 : const Color(0xFFF5F5F5),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/icons/delveri-Icons.svg",
                      width: 16.sp,
                      height: 16.sp,
                      colorFilter: ColorFilter.mode(
                        isDarkMode ? Colors.white70 : Colors.black87,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _locationInfo(from, "20 Jan", isDarkMode),
                        Text(
                          "08:30 AM",
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 32.r,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(height: 4.h),
                        Container(width: 2.w, height: 2.h, decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle)),
                        SizedBox(height: 4.h),
                        Container(width: 2.w, height: 2.h, decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle)),
                        SizedBox(height: 4.h),
                        Container(width: 2.w, height: 2.h, decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle)),
                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white10 : const Color(0xFFF5F5F5),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/icons/Location-icons.svg",
                      width: 16.sp,
                      height: 16.sp,
                      colorFilter: ColorFilter.mode(
                        isDarkMode ? Colors.white70 : Colors.black87,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _locationInfo(to, "20 Jan", isDarkMode),
                        Text(
                          "10:45 PM",
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
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

          SizedBox(height: 16.h),
          Divider(color: isDarkMode ? Colors.white10 : Colors.grey.shade200, thickness: 1, height: 1),
          SizedBox(height: 16.h),

          // Pricing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _priceInfo("Price Per kg", price, isDarkMode),
              _priceInfo("Estimated Total", total, isDarkMode, isBold: true),
            ],
          ),

          SizedBox(height: 20.h),

          if (!isDelivered && !isCancelled) ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.qr_code_2,
                      size: 16.sp,
                      color: const Color(0xFF4A80F0),
                    ),
                    label: Text(
                      "Show QR",
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      side: BorderSide(
                        color: isDarkMode ? Colors.white10 : Colors.grey.shade300,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/icons/Location-icons.svg",
                      width: 16.sp,
                      height: 16.sp,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF4A80F0),
                        BlendMode.srcIn,
                      ),
                    ),
                    label: Text(
                      "Track on Map",
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      side: BorderSide(
                        color: isDarkMode ? Colors.white10 : Colors.grey.shade300,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],

          // Message Button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A80F0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "Message",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusLabel(String label, bool isDarkMode, {bool isActive = false}) {
    return Text(
      label,
      style: GoogleFonts.montserrat(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: isActive 
             ? (isDarkMode ? Colors.white : Colors.black87)
             : (isDarkMode ? Colors.white38 : Colors.grey.shade400),
      ),
    );
  }

  Widget _buildProgressLine(int step, bool isDarkMode) {
    return Row(
      children: List.generate(7, (index) {
        if (index % 2 == 0) {
          int dotIndex = index ~/ 2;
          bool isActive = dotIndex <= step;
          return Container(
            width: 12.r,
            height: 12.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              border: Border.all(
                color: isActive
                    ? const Color(0xFF4A80F0)
                    : Colors.grey.shade300,
                width: 2,
              ),
            ),
          );
        } else {
          int lineIndex = index ~/ 2;
          bool isActive = lineIndex < step;
          return Expanded(
            child: Container(
              height: 2.h,
              color: isActive ? const Color(0xFF4A80F0) : Colors.grey.shade200,
            ),
          );
        }
      }),
    );
  }

  Widget _locationInfo(String city, String date, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          city,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Text(
          date,
          style: GoogleFonts.montserrat(fontSize: 10.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _priceInfo(
    String label,
    String value,
    bool isDarkMode, {
    bool isBold = false,
  }) {
    return Column(
      crossAxisAlignment: isBold
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
