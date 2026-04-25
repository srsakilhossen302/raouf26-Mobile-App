import 'package:get/get.dart';
import '../../../../../helper/shared_preference_helper.dart';

class PublishTripsController extends GetxController {
  final RxInt selectedTab = 0.obs;
  final RxInt requestSubTab = 0.obs;
  final RxString userRole = "".obs;
  final RxString selectedReason = "".obs;
  final List<String> quickReasons = [
    "Sorry, we are no longer available for this date.",
    "Unfortunately, all seats are already reserved.",
    "We are unable to accept this request at the moment.",
  ];

  @override
  void onInit() {
    super.onInit();
    _fetchUserRole();
    if (Get.arguments != null && Get.arguments is int) {
      selectedTab.value = Get.arguments;
    }
  }

  Future<void> _fetchUserRole() async {
    userRole.value = await SharedPreferenceHelper.getUserRole() ?? "";
  }

  final RxString selectedCity = "".obs;
  final RxString selectedDate = "".obs;
  final RxBool showFilterChips = false.obs;

  // Temp variables for the filter sheet
  final RxString tempCity = "Tunis".obs;
  final RxString tempDate = "".obs;

  void applyFilters() {
    selectedCity.value = tempCity.value;
    selectedDate.value = tempDate.value;
    showFilterChips.value = true;
  }

  void resetFilters() {
    selectedCity.value = "";
    selectedDate.value = "";
    tempCity.value = "Tunis";
    tempDate.value = "";
    showFilterChips.value = false;
  }

  void removeCityFilter() {
    selectedCity.value = "";
    if (selectedDate.value.isEmpty) showFilterChips.value = false;
  }

  void removeDateFilter() {
    selectedDate.value = "";
    if (selectedCity.value.isEmpty) showFilterChips.value = false;
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeRequestSubTab(int index) {
    requestSubTab.value = index;
  }

  void selectReason(String reason) {
    selectedReason.value = reason;
  }

  void rejectBooking() {
    Get.snackbar(
      "Booking Rejected",
      "The request has been rejected successfully.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
