import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SenderDetailsController extends GetxController {
  final senderNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  
  final RxString selectedAddress = "20, Aryanah, Ariana, Tunisia".obs;
  
  void useMyDetails() {
    // Logic to fill details with current user's info
    senderNameController.text = "Current User Name";
    phoneNumberController.text = "00000000";
  }
  
  void adjustLocation() {
    // Logic to open map picker
    Get.log("Adjust Location clicked");
  }

  @override
  void onClose() {
    senderNameController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
