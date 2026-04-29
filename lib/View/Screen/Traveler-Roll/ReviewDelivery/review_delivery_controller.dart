import 'package:get/get.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/DeliveryInfo/delivery_info_view.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/PackageDetails/package_details_controller.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/PackageDetails/package_details_view.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/SenderDetails/sender_details_controller.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/SenderDetails/sender_details_view.dart';
import 'package:raouf26mobileapp/View/Screen/Traveler-Roll/DeliveryInfo/delivery_info_controller.dart';

class ReviewDeliveryController extends GetxController {
  // Accessing other controllers
  final packageCtrl = Get.find<PackageDetailsController>();
  final senderCtrl = Get.find<SenderDetailsController>();
  final deliveryCtrl = Get.find<DeliveryInfoController>();

  // Reactive properties linked to original controllers
  RxString get packageSize => packageCtrl.selectedSize;
  String get exactWeight => packageCtrl.customWeight.value.isEmpty ? "0 kg" : "${packageCtrl.customWeight.value} kg";
  String get packageCategory => packageCtrl.selectedCategories.join(", ");
  RxString get packageItems => packageCtrl.packageContent;
  RxString get storagePeriod => packageCtrl.storageDateRange;
  String get storageDays => "${packageCtrl.storageDays.value} days of storage";

  String get senderName => senderCtrl.senderNameController.text;
  String get senderPhone => senderCtrl.phoneNumberController.text;
  RxString get pickupAddress => senderCtrl.selectedAddress;

  String get recipientName => deliveryCtrl.recipientNameController.text;
  String get recipientPhone => deliveryCtrl.phoneNumberController.text;
  RxString get deliveryAddress => deliveryCtrl.selectedAddress;
  RxString get deliverySpeed => deliveryCtrl.selectedDeliverySpeed;
  RxString get deliveryPreference => deliveryCtrl.selectedDeliveryPreference;
  
  final estimatedDistance = "25 km".obs;

  void findTransporter() {
    Get.log("Find Transporter clicked");
  }
  
  void editSection(String section) {
    Get.log("Editing section: $section");
    // Passing a flag to tell the views we are in "Edit Mode"
    switch (section) {
      case "Package":
        Get.to(() => const PackageDetailsScreen(), arguments: {"editMode": true});
        break;
      case "Sender":
      case "Pickup":
        Get.to(() => const SenderDetailsView(), arguments: {"editMode": true});
        break;
      case "Delivery":
        Get.to(() => const DeliveryInfoView(), arguments: {"editMode": true});
        break;
      default:
        Get.log("Unknown section: $section");
    }
  }
}
