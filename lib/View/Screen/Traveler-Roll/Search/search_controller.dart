import 'package:get/get.dart';

class SearchController extends GetxController {
  final RxString pickUpLocation = "".obs;
  final RxString dropLocation = "".obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  void updatePickUp(String value) => pickUpLocation.value = value;
  void updateDrop(String value) => dropLocation.value = value;
  void updateDate(DateTime date) => selectedDate.value = date;

  @override
  void onInit() {
    super.onInit();
  }
}
