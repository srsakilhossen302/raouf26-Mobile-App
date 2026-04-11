import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesController extends GetxController {
  var selectedTab = 0.obs; // 0 for All, 1 for Traveler, 2 for Client

  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[
    {
      'name': 'Sendit Support',
      'message': '24/7 available! How can we help you?',
      'time': '',
      'isSupport': true,
      'isUnread': false,
      'image': 'https://via.placeholder.com/150',
      'subtitle': '',
      'status': '',
      'role': 'all',
    },
    {
      'name': 'Ahmed Bin Salah',
      'message': 'Hi, I\'d like to confirm pickup time for tomorrow ...',
      'time': '09:45 AM',
      'isSupport': false,
      'isUnread': true,
      'image': 'https://via.placeholder.com/150',
      'subtitle': 'Booking Request Paris → Tunis',
      'status': '',
      'role': 'traveler',
    },
    {
      'name': 'Zain Malik',
      'message': 'Hi, I can adjust the pickup location if needed ...',
      'time': '09:30 AM',
      'isSupport': false,
      'isUnread': true,
      'image': 'https://via.placeholder.com/150',
      'subtitle': 'Replied',
      'status': '',
      'role': 'client',
    },
    {
      'name': 'Sarah Johnson',
      'message': 'Hello! Is there enough space for a 12kg parcel ...',
      'time': '07:15 AM',
      'isSupport': false,
      'isUnread': true,
      'image': 'https://via.placeholder.com/150',
      'subtitle': 'Booking Request Rome → Zurich',
      'status': 'Pending',
      'role': 'traveler',
    },
    {
      'name': 'Stephny Matoz',
      'message': 'Hi, I can adjust the pickup location if needed ...',
      'time': '06:30 AM',
      'isSupport': false,
      'isUnread': false,
      'image': 'https://via.placeholder.com/150',
      'subtitle': 'Replied',
      'status': '',
      'role': 'client',
    },
    {
      'name': 'Henly Toriss',
      'message': 'Hello! Is there enough space for a 12kg parcel ...',
      'time': '05:15 AM',
      'isSupport': false,
      'isUnread': false,
      'image': 'https://via.placeholder.com/150',
      'subtitle': 'Booking Request Rome → Zurich',
      'status': '',
      'role': 'traveler',
    },
    {
      'name': 'John Mike',
      'message': 'Hello! Is there enough space for a 12kg parcel ...',
      'time': '05:05 AM',
      'isSupport': false,
      'isUnread': false,
      'image': 'https://via.placeholder.com/150',
      'subtitle': 'Booking Request Rome → Zurich',
      'status': '',
      'role': 'traveler',
    },
  ].obs;

  final RxList<Map<String, dynamic>> archivedMessages =
      <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get filteredMessages {
    if (selectedTab.value == 0) return messages;
    String role = selectedTab.value == 1 ? 'traveler' : 'client';
    return messages
        .where((msg) => msg['isSupport'] == true || msg['role'] == role)
        .toList();
  }

  void onTabSelected(int index) {
    selectedTab.value = index;
  }

  void archiveMessage(Map<String, dynamic> message) {
    messages.remove(message);
    archivedMessages.add(message);
    Get.snackbar(
      "Archived",
      "Conversation archived",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.brightness == Brightness.dark
          ? Colors.grey.shade900
          : Colors.white,
      colorText: Get.theme.brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }

  void deleteMessage(Map<String, dynamic> message) {
    messages.remove(message);
    Get.snackbar(
      "Deleted",
      "Conversation deleted",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.1),
      colorText: Colors.red,
    );
  }
}
