import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublishTripFlowController extends GetxController {
  final RxInt currentStep = 0.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<DateTime> focusedDate = DateTime.now().obs;

  final departureController = TextEditingController();
  final destinationController = TextEditingController();
  final RxString departureTime = "".obs;
  final RxString arrivalTime = "".obs;
  final RxList<String> stops = <String>[].obs;

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }

  void clearSelection() {
    selectedDate.value = null;
  }
}
