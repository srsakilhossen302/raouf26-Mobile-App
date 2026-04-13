import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum BookingStatus { pending, accepted, rejected }

class ChatController extends GetxController {
  var status = BookingStatus.pending.obs;
  var messageController = "".obs;
  var selectedReason = "".obs;
  var userData = <String, dynamic>{}.obs;

  final List<String> quickReasons = [
    "Sorry, we are no longer available for this date.",
    "Unfortunately, all seats are already reserved.",
    "We are unable to accept this request at the moment.",
  ];

  final List<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // In a real app, messages would come from a database.
    // For demo, we'll initialize with some default ones if needed.
  }

  void setUserData(Map<String, dynamic> data) {
    userData.value = data;
  }

  void acceptBooking() {
    status.value = BookingStatus.accepted;
  }

  void rejectBooking() {
    status.value = BookingStatus.rejected;
  }

  void selectReason(String reason) {
    selectedReason.value = reason;
  }

  bool _containsSensitiveInfo(String text) {
    // Regular expression to detect phone numbers and emails
    final phoneRegex = RegExp(r'(\+?\d{1,4}[\s-]?)?\(?\d{2,4}\)?[\s-]?\d{3,4}[\s-]?\d{3,4}');
    final emailRegex = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
    
    return phoneRegex.hasMatch(text) || emailRegex.hasMatch(text);
  }

  void sendMessage(String text) {
    if (text.trim().isNotEmpty) {
      if (_containsSensitiveInfo(text)) {
        Get.snackbar(
          "Security Warning",
          "For your protection, please keep communication inside the app. Avoid sharing contact information directly.",
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
        return;
      }
      
      messages.add({
        'isMe': true,
        'text': text,
        'time': '10:00 AM', // Placeholder time
        'isRead': false,
      });
    }
  }
}
