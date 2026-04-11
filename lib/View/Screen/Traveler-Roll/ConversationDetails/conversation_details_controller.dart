import 'package:get/get.dart';
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
