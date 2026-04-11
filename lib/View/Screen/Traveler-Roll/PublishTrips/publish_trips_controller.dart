import 'package:get/get.dart';

class PublishTripsController extends GetxController {
  final RxInt selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }
}
