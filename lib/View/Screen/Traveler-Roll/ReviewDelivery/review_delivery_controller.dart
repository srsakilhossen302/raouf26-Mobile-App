import 'package:get/get.dart';

class ReviewDeliveryController extends GetxController {
  // Mock Data for Review
  final packageSize = "Medium (20-50 kg)".obs;
  final exactWeight = "15 kg".obs;
  final packageCategory = "Food".obs;
  final packageItems = "Makrouna".obs;
  final storagePeriod = "Jan 29, 2026 - Jan 31, 2026".obs;
  final storageDays = "3 days of storage".obs;
  
  final senderName = "Mohamed Ali".obs;
  final senderPhone = "+216 20123456".obs;
  final pickupAddress = "20, Aryanah, Ariana, Tunisia".obs;
  
  final recipientName = "Alice Smith".obs;
  final recipientPhone = "+216 06223344".obs;
  final deliveryAddress = "40, Sidi Bou Said, Tunisia".obs;
  final deliverySpeed = "Urgent".obs;
  final deliveryPreference = "Recipient's Address".obs;
  
  final estimatedDistance = "25 km".obs;

  void findTransporter() {
    Get.log("Find Transporter clicked");
  }
  
  void editSection(String section) {
    Get.log("Editing section: $section");
  }
}
