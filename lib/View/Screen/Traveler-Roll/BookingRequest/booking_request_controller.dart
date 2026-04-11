import 'package:get/get.dart';

class BookingRequestController extends GetxController {
  // Mock Data for Booking Request
  final transporterName = "Ahmed Bin Salah".obs;
  final transporterImage = "https://randomuser.me/api/portraits/men/1.jpg".obs;
  final isOnline = true.obs;
  
  final bookingStatus = "Waiting Response".obs;
  final deliverySpeed = "Urgent".obs;
  
  final fromCity = "Tunisia".obs;
  final toCity = "France".obs;
  final fromDate = "20 Jan".obs;
  final toDate = "20 Jan".obs;
  final fromTime = "08:30 AM".obs;
  final toTime = "10:45 PM".obs;
  
  final packageSize = "Medium (15kg)".obs;
  final deliveryTime = "Jan 29, 2026 - Jan 31, 2026".obs;
  final totalEstimate = "37.50 TND".obs;

  void cancelReservation() {
    Get.log("Reservation cancelled");
    Get.back();
  }
}
