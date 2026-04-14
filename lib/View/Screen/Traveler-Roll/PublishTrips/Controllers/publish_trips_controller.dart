import 'package:get/get.dart';

class PublishTripsController extends GetxController {
  final RxInt selectedTab = 0.obs;
  final RxInt requestSubTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeRequestSubTab(int index) {
    requestSubTab.value = index;
  }
}
