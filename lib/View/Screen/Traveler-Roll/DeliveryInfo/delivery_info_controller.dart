import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryInfoController extends GetxController {
  final recipientNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  
  final RxString selectedAddress = "40, Sidi Bu Jafar, Sousse, Tunisia".obs;
  
  // Delivery Speed Options
  final RxString selectedSpeed = "Normal".obs;
  final List<String> speedOptions = ["Normal", "Urgent", "ASAP"];
  
  // Delivery Handed Over Preference Options
  final RxString selectedPreference = "Drop Point".obs;
  final List<String> preferenceOptions = ["Drop Point", "Recipient's Address", "Via Post"];
  
  // Mock Contacts
  final List<Map<String, String>> contacts = [
    {"name": "Alice", "image": "https://randomuser.me/api/portraits/women/44.jpg"},
    {"name": "Bob", "image": "https://randomuser.me/api/portraits/men/32.jpg"},
  ];

  void setSpeed(String speed) => selectedSpeed.value = speed;
  void setPreference(String preference) => selectedPreference.value = preference;
  
  void adjustLocation() {
    Get.log("Adjust Location clicked in Delivery Info");
  }

  @override
  void onClose() {
    recipientNameController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
