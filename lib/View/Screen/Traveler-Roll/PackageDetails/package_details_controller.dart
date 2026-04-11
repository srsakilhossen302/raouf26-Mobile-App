import 'package:get/get.dart';

class PackageDetailsController extends GetxController {
  // Package Size selection
  final RxString selectedSize = "Small".obs;
  
  // Custom Weight
  final RxString customWeight = "".obs;
  
  // Package Content
  final RxString packageContent = "".obs;
  
  // Package Categories (Multiple selection)
  final RxList<String> selectedCategories = <String>[].obs;
  
  // Storage Switch
  final RxBool needStorage = false.obs;
  
  // Storage Dates
  final RxString storageDateRange = "1-29-2026 - 1-31-2026".obs;

  void updateSize(String size) {
    selectedSize.value = size;
  }

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  void toggleStorage(bool value) {
    needStorage.value = value;
  }
}
