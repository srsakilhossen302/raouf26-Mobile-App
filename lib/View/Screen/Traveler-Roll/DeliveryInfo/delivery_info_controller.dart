import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryInfoController extends GetxController {
  final recipientNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  
  final RxString selectedAddress = "40, Sidi Bu Jafar, Sousse, Tunisia".obs;
  
  // Pickup Method Options
  final RxString selectedPickupMethod = "Pickup from my address".obs;
  final List<String> pickupMethodOptions = [
    "Pickup from my address",
    "Drop off at a point",
    "Meet the transporter"
  ];

  // Delivery Speed Options
  final RxString selectedDeliverySpeed = "Normal".obs;
  final List<String> deliverySpeedOptions = [
    "Normal",
    "Urgent",
    "ASAP"
  ];

  void setDeliverySpeed(String speed) => selectedDeliverySpeed.value = speed;

  // Delivery Method Options
  final RxString selectedDeliveryMethod = "Recipient address".obs;
  final List<String> deliveryMethodOptions = [
    "Recipient address",
    "Drop point",
    "Via post"
  ];

  // Delivery Preference Options
  final RxString selectedDeliveryPreference = "Drop Point".obs;
  final List<String> deliveryPreferenceOptions = [
    "Drop Point",
    "Recipient's Address",
    "Via Post"
  ];

  void setDeliveryPreference(String pref) => selectedDeliveryPreference.value = pref;

  // Mock Contacts
  final List<Map<String, String>> contacts = [
    {"name": "Alice", "image": "https://randomuser.me/api/portraits/women/44.jpg"},
    {"name": "Bob", "image": "https://randomuser.me/api/portraits/men/32.jpg"},
  ];

  void setPickupMethod(String method) => selectedPickupMethod.value = method;
  void setDeliveryMethod(String method) => selectedDeliveryMethod.value = method;
  
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
