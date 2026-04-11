import 'package:get/get.dart';

class TravelerSearchController extends GetxController {
  final RxString pickUpLocation = "".obs;
  final RxString dropLocation = "".obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // Address labels for display
  final RxString pickUpAddress = "Where should it be delivered?".obs;
  final RxString dropAddress = "Where should it be delivered?".obs;

  void updatePickUp(String value) {
    pickUpLocation.value = value;
    pickUpAddress.value = value.isEmpty
        ? "Where should it be delivered?"
        : value;
  }

  void updateDrop(String value) {
    dropLocation.value = value;
    dropAddress.value = value.isEmpty ? "Where should it be delivered?" : value;
  }

  void updateDate(DateTime date) => selectedDate.value = date;

  void clearPickUp() {
    pickUpLocation.value = "";
    pickUpAddress.value = "Where should it be delivered?";
  }

  void clearDrop() {
    dropLocation.value = "";
    dropAddress.value = "Where should it be delivered?";
  }

  @override
  void onInit() {
    super.onInit();
  }
}
