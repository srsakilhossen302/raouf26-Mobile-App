import 'package:get/get.dart';

enum BookingStatus { pending, accepted, rejected }

class ChatController extends GetxController {
  var status = BookingStatus.pending.obs;
  var messageController = "".obs;
  var selectedReason = "".obs;

  final List<String> quickReasons = [
    "Sorry, we are no longer available for this date.",
    "Unfortunately, all seats are already reserved.",
    "We are unable to accept this request at the moment.",
  ];

  final List<Map<String, dynamic>> messages = <Map<String, dynamic>>[
    {
      'isMe': false,
      'text': 'Hi, what time will the team arrive today?',
      'time': '9:15 AM',
    },
    {
      'isMe': true,
      'text': 'Hello Sarah! The team will arrive at 10:30 AM.',
      'time': '9:18 AM',
      'isRead': true,
    },
  ].obs;

  void acceptBooking() {
    status.value = BookingStatus.accepted;
  }

  void rejectBooking() {
    status.value = BookingStatus.rejected;
  }

  void selectReason(String reason) {
    selectedReason.value = reason;
  }

  void sendMessage(String text) {
    if (text.trim().isNotEmpty) {
      messages.add({
        'isMe': true,
        'text': text,
        'time': '10:00 AM', // Placeholder time
        'isRead': false,
      });
    }
  }
}
