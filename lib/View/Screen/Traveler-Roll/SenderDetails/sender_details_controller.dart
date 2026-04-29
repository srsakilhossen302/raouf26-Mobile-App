import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Search/map_picker_screen.dart';

class SenderDetailsController extends GetxController {
  final senderNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  
  final RxString selectedAddress = "20, Aryanah, Ariana, Tunisia".obs;
  
  void useMyDetails() {
    // Logic to fill details with current user's info
    senderNameController.text = "Current User Name";
    phoneNumberController.text = "00000000";
  }
  
  Future<void> adjustLocation() async {
    var result = await Get.to(() => const MapPickerScreen(title: "Adjust Location"));
    if (result != null && result is String) {
      selectedAddress.value = result;
    }
  }

  @override
  void onClose() {
    senderNameController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
