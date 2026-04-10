import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widget/custom_bottom_nav_bar.dart';

class MyParcelsScreen extends StatefulWidget {
  const MyParcelsScreen({super.key});

  @override
  State<MyParcelsScreen> createState() => _MyParcelsScreenState();
}

class _MyParcelsScreenState extends State<MyParcelsScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ["All", "Active", "Delivered", "Cancelled"];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FE),
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
                    : Colors.white,
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedFilter == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = index),
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
                          : Colors.transparent,
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
                        _filters[index],
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
            ),
          ),

          SizedBox(height: 20.h),

          // Parcel List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                _parcelCard(
                  name: "Ahmed Bin Salah",
                  date: "Thu 20 Jan, 2026",
                  status: "In Transit",
                  statusStep: 2,
                  from: "Tunisia",
                  to: "France",
                  price: "2.5 TND/ kg",
                  total: "37.50 TND",
                  isDarkMode: isDarkMode,
                ),
                SizedBox(height: 20.h),
                _parcelCard(
                  name: "Ahmed Bin Salah",
                  date: "Thu 20 Jan, 2026",
                  status: "Delivered",
                  statusStep: 3,
                  from: "Tunisia",
                  to: "France",
                  price: "2.5 TND/ kg",
                  total: "37.50 TND",
                  isDarkMode: isDarkMode,
                  isDelivered: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _parcelCard({
    required String name,
    required String date,
    required String status,
    required int statusStep,
    required String from,
    required String to,
    required String price,
    required String total,
    required bool isDarkMode,
    bool isDelivered = false,
  }) {
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
                  color: isDelivered
                      ? const Color(0xFFE6F7ED)
                      : const Color(0xFFE8EFFF),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.montserrat(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: isDelivered
                        ? const Color(0xFF22C55E)
                        : const Color(0xFF4A80F0),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Status Tracker
          if (!isDelivered) ...[
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.03)
                    : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _statusLabel("Booked", isDarkMode),
                      _statusLabel("Picked Up", isDarkMode),
                      _statusLabel("In Transit", isDarkMode),
                      _statusLabel("Delivered", isDarkMode),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  _buildProgressLine(statusStep),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],

          // Route Info
          Row(
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    "assets/icons/delveri-Icons.svg",
                    width: 20.sp,
                    height: 20.sp,
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  Container(
                    height: 20.h,
                    width: 1.w,
                    color: Colors.grey.shade300,
                  ),
                  SvgPicture.asset(
                    "assets/icons/Location-icons.svg",
                    width: 20.sp,
                    height: 20.sp,
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _locationInfo(from, "20 Jan", isDarkMode),
                        Text(
                          "08:30 AM",
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _locationInfo(to, "20 Jan", isDarkMode),
                        Text(
                          "10:45 PM",
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Pricing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _priceInfo("Price Per kg", price, isDarkMode),
              _priceInfo("Estimated Total", total, isDarkMode, isBold: true),
            ],
          ),

          SizedBox(height: 20.h),

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

  Widget _statusLabel(String label, bool isDarkMode) {
    return Text(
      label,
      style: GoogleFonts.montserrat(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: isDarkMode ? Colors.white70 : Colors.black87,
      ),
    );
  }

  Widget _buildProgressLine(int step) {
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
              color: isActive ? const Color(0xFF4A80F0) : Colors.transparent,
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
