import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Widgets/booking_request_card.dart';
import '../../../Traveler-Roll/PublishTrips/Widgets/booking_details_modal.dart';
import '../controller/transporter_new_requests_controller.dart';

class TransporterNewRequestsView extends StatelessWidget {
  const TransporterNewRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransporterNewRequestsController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "New Requests",
          style: GoogleFonts.manrope(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        return ListView.builder(
          padding: EdgeInsets.all(20.r),
          itemCount: controller.requests.length,
          itemBuilder: (context, index) {
            final request = controller.requests[index];
            return NewRequestCard(request: request, isDarkMode: isDarkMode);
          },
        );
      }),
    );
  }
}

class NewRequestCard extends StatelessWidget {
  final NewRequestModel request;
  final bool isDarkMode;

  const NewRequestCard({
    super.key,
    required this.request,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return BookingRequestCard(
      userName: request.userName,
      userImage: request.userImage,
      timeAgo: request.timeAgo,
      status: request.status,
      fromCity: request.fromCity,
      toCity: request.toCity,
      fromDate: request.fromDate,
      toDate: request.toDate,
      fromTime: request.fromTime,
      toTime: request.toTime,
      packageSize: request.packageSize,
      packageStatus: request.packageStatus,
      packagePhotos: request.packagePhotos,
      totalPrice: "€${request.totalEstimate.toStringAsFixed(0)}",
      rejectionReasons: const [
        "Sorry, we are no longer available for this date.",
        "The package size or weight is not suitable for my current capacity.",
        "I have changed my travel route and can no longer fulfill this request.",
        "Other"
      ],
    );
  }
}
