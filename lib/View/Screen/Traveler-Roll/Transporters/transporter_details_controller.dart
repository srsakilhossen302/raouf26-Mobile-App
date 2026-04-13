import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/Transporters/transporters_controller.dart';

class TransporterDetailsController extends GetxController {
  final Transporter transporter;
  TransporterDetailsController(this.transporter);

  final RxString discountCode = "".obs;
  final RxBool isCodeApplied = false.obs;
  final RxString codeError = "".obs;
  final RxString successMessage = "".obs;

  final RxDouble discountAmount = 0.0.obs;
  final RxDouble originalTotal = 0.0.obs;
  final RxDouble finalTotal = 0.0.obs;

  final TextEditingController codeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Parse the estimated total string (e.g., "37.50 TND" -> 37.50)
    originalTotal.value = _parseAmount(transporter.estimatedTotal);
    finalTotal.value = originalTotal.value;
  }

  double _parseAmount(String amountStr) {
    try {
      final numericPart = amountStr.replaceAll(RegExp(r'[^0-9.]'), '');
      return double.parse(numericPart);
    } catch (e) {
      return 0.0;
    }
  }

  void applyDiscount() {
    final code = codeController.text.trim().toUpperCase();
    codeError.value = "";
    successMessage.value = "";
    isCodeApplied.value = false;
    discountAmount.value = 0.0;
    finalTotal.value = originalTotal.value;

    if (code.isEmpty) {
      codeError.value = "Please enter a code";
      return;
    }

    // Mock validation logic
    if (code == "SAVE10") {
      // Percentage discount
      discountAmount.value = originalTotal.value * 0.10;
      _applyValidCode("10% Discount applied!");
    } else if (code == "FIXED5") {
      // Fixed amount discount
      discountAmount.value = 5.0;
      _applyValidCode("5 TND Discount applied!");
    } else if (code == "FIRST") {
      // First booking logic
      discountAmount.value = originalTotal.value * 0.20;
      _applyValidCode("First booking 20% discount applied!");
    } else {
      codeError.value = "Invalid or expired code";
    }
  }

  void _applyValidCode(String message) {
    isCodeApplied.value = true;
    successMessage.value = message;
    finalTotal.value = originalTotal.value - discountAmount.value;
    if (finalTotal.value < 0) finalTotal.value = 0;
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }
}
