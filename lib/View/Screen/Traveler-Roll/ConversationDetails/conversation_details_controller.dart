import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/ConversationDetails/parcel_label_preview_view.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Transporters/travel_pricing_details_view.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Transporters/transporters_controller.dart';

class ConversationDetailsController extends GetxController {
  final transporterName = "Ahmed Bin Salah".obs;
  final transporterImage = "https://randomuser.me/api/portraits/men/1.jpg".obs;

  final clientName = "Zain Malik".obs;
  final clientImage = "https://randomuser.me/api/portraits/men/2.jpg".obs;

  // Travel Information
  final route = "Tunis → Paris".obs;
  final departureDate = "28 Jan 2026".obs;
  final returnDate = "5 Feb 2026".obs;

  // Subtitle info
  final tripInfo = "28 Jan • Tunis → Paris".obs;

  // Pricing
  final pricePerKg = "2.5 TND/ kg".obs;
  final packageWeight = "15 kg".obs;
  final totalToPay = "37.50 TND".obs;

  void contactSupport() {
    Get.log("Contacting Support");
  }

  void onActionTap(String action) {
    Get.log("Action tapped: $action");
    if (action == "Print Parcel Label") {
      Get.to(() => const ParcelLabelPreviewView());
    } else if (action == "Star Conversation") {
      showStarredDialog();
    } else if (action == "Mark as Unread") {
      showRemovedFromStarredDialog();
    }
  }

  void showRemovedFromStarredDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80.r,
                height: 80.r,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.star, color: Colors.black87, size: 40.sp),
              ),
              SizedBox(height: 24.h),
              Text(
                "Removed from Starred",
                style: GoogleFonts.montserrat(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "This conversation has been removed from your important chats.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 13.sp,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showStarredDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80.r,
                height: 80.r,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.star, color: Colors.black87, size: 40.sp),
              ),
              SizedBox(height: 24.h),
              Text(
                "Added to Starred",
                style: GoogleFonts.montserrat(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "This conversation is now marked as important.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 13.sp,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToTransporterProfile() {
    // Create a Transporter object with the current data
    final transporter = Transporter(
      name: transporterName.value,
      imageUrl: transporterImage.value,
      rating: 4.8,
      totalTrips: 154,
      vehicleType: "Utility Van",
      from: "Tunis",
      to: "Paris",
      fromDate: "28 Jan",
      toDate: "5 Feb",
      fromTime: "08:30 AM",
      toTime: "10:45 PM",
      pricePerKg: pricePerKg.value,
      estimatedTotal: totalToPay.value,
      alsoTravelingTo: ["Italy", "Switzerland"],
      isVerified: true,
    );

    Get.to(() => TravelPricingDetailsView(transporter: transporter));
  }
}
