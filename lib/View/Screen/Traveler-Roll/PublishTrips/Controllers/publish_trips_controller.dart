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
  }

  Future<void> _fetchUserRole() async {
    userRole.value = await SharedPreferenceHelper.getUserRole() ?? "";
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeRequestSubTab(int index) {
    requestSubTab.value = index;
  }
}
