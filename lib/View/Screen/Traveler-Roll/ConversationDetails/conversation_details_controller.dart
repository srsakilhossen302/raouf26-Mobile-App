import 'package:get/get.dart';

class ConversationDetailsController extends GetxController {
  final transporterName = "Ahmed Bin Salah".obs;
  final transporterImage = "https://randomuser.me/api/portraits/men/1.jpg".obs;
  final tripInfo = "28 Jan • Tunis → Paris".obs;
  
  final clientName = "Zain Malik".obs;
  final clientImage = "https://randomuser.me/api/portraits/men/3.jpg".obs;

  void onActionTap(String action) {
    Get.log("Action tapped: $action");
  }
}
