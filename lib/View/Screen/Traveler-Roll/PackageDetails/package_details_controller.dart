import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PackageDetailsController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  // Image paths
  final Rx<File?> exteriorImage = Rx<File?>(null);
  final Rx<File?> interiorImage = Rx<File?>(null);

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

  Future<void> pickImage(bool isExterior) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      if (isExterior) {
        exteriorImage.value = File(image.path);
      } else {
        interiorImage.value = File(image.path);
      }
    }
  }

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
