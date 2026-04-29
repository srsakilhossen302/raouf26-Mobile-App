import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  final RxString storageDateRange = "Select Date Range".obs;
  final Rxn<DateTime> rangeStart = Rxn<DateTime>();
  final Rxn<DateTime> rangeEnd = Rxn<DateTime>();
  final RxInt storageDays = 0.obs;

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

  void updateDateRange(DateTime? start, DateTime? end) {
    rangeStart.value = start;
    rangeEnd.value = end;

    if (start != null && end != null) {
      int days = end.difference(start).inDays + 1;
      storageDays.value = days;
      storageDateRange.value = "${DateFormat('M-dd-yyyy').format(start)} - ${DateFormat('M-dd-yyyy').format(end)}";
    } else if (start != null) {
      storageDays.value = 1;
      storageDateRange.value = DateFormat('M-dd-yyyy').format(start);
    } else {
      storageDays.value = 0;
      storageDateRange.value = "Select Date Range";
    }
  }
}
