import 'package:get/get.dart';

class MyParcelsController extends GetxController {
  final RxInt selectedFilter = 0.obs;
  final RxList<String> filters = <String>[
    "All",
    "Active",
    "Delivered",
    "Cancelled",
  ].obs;

  void updateFilter(int index) {
    selectedFilter.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch parcels here
  }
}
