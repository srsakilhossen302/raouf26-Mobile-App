import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TravelerSearchController extends GetxController {
  static TravelerSearchController get instance => Get.find();
  final RxString pickUpLocation = "".obs;
  final RxString dropLocation = "".obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxString selectedDateStr = "Choose pickup date".obs;


  // Address labels for display
  final RxString pickUpAddress = "Where should it be picked up?".obs;
  final RxString dropAddress = "Where should it be delivered?".obs;

  void updatePickUp(String value) {
    pickUpLocation.value = value;
    pickUpAddress.value = value.isEmpty
        ? "Where should it be picked up?"
        : value;
  }

  void updateDrop(String value) {
    dropLocation.value = value;
    dropAddress.value = value.isEmpty ? "Where should it be delivered?" : value;
  }

  void updateDate(DateTime date) {
    selectedDate.value = date;
    try {
      selectedDateStr.value = DateFormat('dd MMM, yyyy').format(date);
    } catch (e) {
      selectedDateStr.value = "${date.day} ${date.month}, ${date.year}";
    }
  }

  void clearDate() {
    selectedDate.value = null;
    selectedDateStr.value = "Choose pickup date";
  }

  void clearPickUp() {
    pickUpLocation.value = "";
    pickUpAddress.value = "Where should it be picked up?";
  }

  void clearDrop() {
    dropLocation.value = "";
    dropAddress.value = "Where should it be delivered?";
  }

  void useMyPosition() {
    // Mock current position
    pickUpAddress.value = "Current Location: 123 Main St, Tunis";
    pickUpLocation.value = "Current Location: 123 Main St, Tunis";
  }

  @override
  void onInit() {
    super.onInit();
  }
}
