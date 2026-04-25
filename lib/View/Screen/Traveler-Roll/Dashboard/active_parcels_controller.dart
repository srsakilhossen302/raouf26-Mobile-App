import 'package:get/get.dart';

class ActiveParcelsController extends GetxController {
  var selectedReason = "".obs;
  final List<String> quickReasons = [
    "Sorry, I changed my mind about sending this parcel.",
    "Found another transporter who is cheaper.",
    "The delivery timeline has changed.",
    "Other"
  ];

  void setSelectedReason(String reason) {
    selectedReason.value = reason;
  }
}
