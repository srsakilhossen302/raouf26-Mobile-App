import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AccountSafetyController extends GetxController {
  var isFaceRecognitionEnabled = false.obs;
  var isBiometricLoginEnabled = false.obs;
  var isTwoLayersProtectionEnabled = false.obs;

  // Initial score is 25% (Email and PIN are usually verified by default in these flows)
  var baseScore = 25.obs;

  double get safetyScore {
    int additionalScore = 0;
    if (isFaceRecognitionEnabled.value) additionalScore += 25;
    if (isBiometricLoginEnabled.value) additionalScore += 25;
    if (isTwoLayersProtectionEnabled.value) additionalScore += 25;
    
    return (baseScore.value + additionalScore).toDouble() / 100;
  }

  int get safetyScorePercentage => (safetyScore * 100).toInt();

  Color get scoreColor {
    int score = safetyScorePercentage;
    if (score <= 25) return Colors.red;
    if (score <= 50) return Colors.orange;
    if (score <= 75) return Colors.blue;
    return Colors.green;
  }

  void toggleFaceRecognition(bool value) {
    isFaceRecognitionEnabled.value = value;
  }

  void toggleBiometricLogin(bool value) {
    isBiometricLoginEnabled.value = value;
  }

  void toggleTwoLayersProtection(bool value) {
    isTwoLayersProtectionEnabled.value = value;
  }
}
