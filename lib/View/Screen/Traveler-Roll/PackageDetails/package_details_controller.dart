import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PackageDetailsController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  // Image lists (max 5 each)
  final RxList<File> exteriorImages = <File>[].obs;
  final RxList<File> interiorImages = <File>[].obs;

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
    if (isExterior) {
      if (exteriorImages.length >= 5) {
        Get.snackbar(
          "Limit Reached",
          "You can only upload up to 5 exterior photos.",
        );
        return;
      }
    } else {
      if (interiorImages.length >= 5) {
        Get.snackbar(
          "Limit Reached",
          "You can only upload up to 5 interior photos.",
        );
        return;
      }
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (isExterior) {
        exteriorImages.add(File(image.path));
      } else {
        interiorImages.add(File(image.path));
      }
    }
  }

  void removeImage(int index, bool isExterior) {
    if (isExterior) {
      exteriorImages.removeAt(index);
    } else {
      interiorImages.removeAt(index);
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
