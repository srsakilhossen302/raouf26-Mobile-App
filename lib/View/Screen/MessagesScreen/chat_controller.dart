import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raouf26mobileapp/Utils/custom_snackbar.dart';

enum BookingStatus { pending, accepted, rejected }

class ChatController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        // In a real app, you would upload this image to a server
        // For now, we'll just add a placeholder message to the chat
        messages.add({
          'isMe': true,
          'text': "📷 Image sent",
          'time': 'Just now',
          'isRead': false,
          'imagePath': image.path,
        });
      }
    } catch (e) {
      CustomSnackbar.error(title: "Error", message: "Could not pick image: $e");
    }
  }
  var status = BookingStatus.pending.obs;
  var messageController = "".obs;
  var selectedReason = "".obs;
  var userData = <String, dynamic>{}.obs;
  final TextEditingController messageTextController = TextEditingController();

  @override
  void onClose() {
    messageTextController.dispose();
    super.onClose();
  }

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
    if (data['isSupport'] == true || data['directContact'] == true) {
      status.value = BookingStatus.accepted;
      if (messages.isEmpty && data['isSupport'] == true) {
        messages.add({
          'isMe': false,
          'text': data['message'] ?? 'How can we help you?',
          'time': 'Just now',
          'isRead': true,
        });
      }
    }
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
        CustomSnackbar.warning(
          title: "Security Warning",
          message: "For your protection, please keep communication inside the app. Avoid sharing contact information directly.",
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
