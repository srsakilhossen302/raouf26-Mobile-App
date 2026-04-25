import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../Widgets/booking_request_card.dart';
import '../PublishTrips/Widgets/booking_details_modal.dart';
import 'active_parcels_controller.dart';

class ActiveParcelsPage extends StatelessWidget {
  const ActiveParcelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ActiveParcelsController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          "Active Requests",
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildRequestCard(
            name: "Ahmad B.",
            time: "5 hrs ago",
            status: "Pending",
            fromCity: "Tunis",
            fromDate: "14 Jan",
            fromTime: "08:30 AM",
            toCity: "Paris",
            toDate: "14 Jan",
            toTime: "10:45 PM",
            packageSize: "Medium (15kg)",
            packageStatus: "Urgent",
            estimate: "€25",
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 24.h),
          _buildRequestCard(
            name: "Sarah L.",
            time: "1 day ago",
            status: "Pending",
            fromCity: "London",
            fromDate: "16 Jan",
            fromTime: "10:00 AM",
            toCity: "Berlin",
            toDate: "18 Jan",
            toTime: "06:00 PM",
            packageSize: "Small (5kg)",
            packageStatus: "Normal",
            estimate: "€15",
            isDarkMode: isDarkMode,
            isNormal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard({
    required String name,
    required String time,
    required String status,
    required String fromCity,
    required String fromDate,
    required String fromTime,
    required String toCity,
    required String toDate,
    required String toTime,
    required String packageSize,
    required String packageStatus,
    required String estimate,
    required bool isDarkMode,
    bool isNormal = false,
  }) {
    return BookingRequestCard(
      userName: name,
      userImage: "https://i.pravatar.cc/150?u=${name.hashCode}",
      timeAgo: time,
      status: status,
      fromCity: fromCity,
      toCity: toCity,
      fromDate: fromDate,
      toDate: toDate,
      fromTime: fromTime,
      toTime: toTime,
      packageSize: packageSize,
      packageStatus: packageStatus,
      totalPrice: estimate,
    );
  }
}
