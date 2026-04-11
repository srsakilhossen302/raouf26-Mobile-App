import 'package:get/get.dart';

class MyParcelsController extends GetxController {
  final RxInt selectedFilter = 0.obs;
  final List<String> filters = ["All", "Active", "Delivered", "Cancelled"];

  void updateFilter(int index) {
    selectedFilter.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch parcels here
  }
}
