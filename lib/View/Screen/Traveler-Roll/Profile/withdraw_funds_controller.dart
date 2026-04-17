import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawFundsController extends GetxController {
  final double availableBalance = 2450.00;
  final TextEditingController amountController = TextEditingController();
  
  var selectedMethodIndex = 0.obs;
  var selectedPercentage = (-1.0).obs;

  void setAmountByPercentage(double percentage) {
    selectedPercentage.value = percentage;
    double amount = availableBalance * percentage;
    amountController.text = amount.toStringAsFixed(2);
  }

  void selectMethod(int index) {
    selectedMethodIndex.value = index;
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}
