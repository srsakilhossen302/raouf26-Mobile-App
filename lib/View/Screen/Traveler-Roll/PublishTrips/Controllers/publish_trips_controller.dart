import 'package:get/get.dart';
import '../../../../../helper/shared_preference_helper.dart';

class PublishTripsController extends GetxController {
  final RxInt selectedTab = 0.obs;
  final RxInt requestSubTab = 0.obs;
  final RxString userRole = "".obs;

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
}
