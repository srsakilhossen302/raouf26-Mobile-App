import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublishTripFlowController extends GetxController {
  final RxInt currentStep = 0.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<DateTime> focusedDate = DateTime.now().obs;

  final departureController = TextEditingController();
  final destinationController = TextEditingController();
  final RxString departureText = "".obs;
  final RxString destinationText = "".obs;
  final RxString departureTime = "".obs;
  final RxString arrivalTime = "".obs;
  final RxList<String> stops = <String>[].obs;

  // Prices & Capacity
  final RxString selectedCurrency = "TND".obs;
  final RxString selectedCountryName = "Tunisia".obs;
  final RxString selectedCountryFlag = "🇹🇳".obs;
  final pricePerDocumentController = TextEditingController();
  final pricePerPackageController = TextEditingController();
  final RxBool canCarryDocuments = false.obs;
  final RxBool canCarryPackages = true.obs;
  final capacityController = TextEditingController();

  // Travel Details
  final RxString selectedTravelMode = "Flight".obs;
  final RxString selectedAirline = "Select Airline".obs;
  final flightNumberController = TextEditingController();

  // Car Details
  final RxString selectedVehicleType = "Select Vehicle Type".obs;
  final licensePlateController = TextEditingController();

  // Train Details
  final trainNumberController = TextEditingController();

  // Bus Details
  final busNumberController = TextEditingController();

  // Boat Details
  final vesselNameController = TextEditingController();

  // Other Details
  final otherDescriptionController = TextEditingController();

  // Trip Rules & Details
  final RxList<String> rules = <String>[].obs;
  final RxList<String> selectedWhatYouAccept = <String>[].obs;
  final tripDescriptionController = TextEditingController();
  final addRuleController = TextEditingController();

  void nextStep() {
    if (currentStep.value == 0) {
      if (departureTime.value.isNotEmpty && arrivalTime.value.isNotEmpty) {
        currentStep.value = 2;
      } else {
        currentStep.value = 1;
      }
    } else if (currentStep.value < 5) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }

  void clearSelection() {
    selectedDate.value = null;
  }
}
