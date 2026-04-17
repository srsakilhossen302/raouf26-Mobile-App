import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/trip_model.dart';

class PublishTripFlowController extends GetxController {
  final RxInt currentStep = 0.obs;
  final RxBool isEditMode = false.obs;
  final RxInt targetStep = 0.obs;
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

  void populateFromTrip(TripModel trip) {
    departureController.text = trip.departureCity;
    destinationController.text = trip.arrivalCity;
    departureText.value = trip.departureCity;
    destinationText.value = trip.arrivalCity;
    departureTime.value = trip.departureTime;
    arrivalTime.value = trip.arrivalTime;
    capacityController.text = trip.maxWeight;
    pricePerPackageController.text = trip.pricePerKg;
    selectedTravelMode.value = trip.travelMode;

    // Handle stops (comma separated string in model to list)
    stops.clear();
    if (trip.stops.isNotEmpty) {
      stops.addAll(trip.stops.split(',').map((e) => e.trim()));
    }
  }

  void nextStep() {
    if (isEditMode.value && currentStep.value == targetStep.value) {
      Get.back();
      isEditMode.value = false;
      return;
    }

    if (currentStep.value == 0) {
      if (departureTime.value.isNotEmpty && arrivalTime.value.isNotEmpty) {
        currentStep.value = 2;
      } else {
        currentStep.value = 1;
      }
    } else if (currentStep.value < 6) {
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

  bool validateTrip() {
    // 1. Check Date
    if (selectedDate.value == null) {
      Get.snackbar("Error", "Please select a travel date.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    // 2. Check Departure & Destination
    if (departureController.text.isEmpty ||
        destinationController.text.isEmpty) {
      Get.snackbar(
          "Error", "Please provide both departure and destination cities.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    // 3. Check Travel Times
    if (departureTime.value.isEmpty || arrivalTime.value.isEmpty) {
      Get.snackbar("Error", "Please set your departure and arrival times.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    // 4. Check Capacity
    if (capacityController.text.isEmpty) {
      Get.snackbar("Error", "Please specify the suitcase capacity.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    // 5. Check Pricing
    if (!canCarryDocuments.value && !canCarryPackages.value) {
      Get.snackbar(
          "Error",
          "Please select at least one item type (Packages or Documents).",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (canCarryDocuments.value && pricePerDocumentController.text.isEmpty) {
      Get.snackbar("Error", "Please set a price for document delivery.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (canCarryPackages.value && pricePerPackageController.text.isEmpty) {
      Get.snackbar("Error", "Please set a price per kg for package delivery.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    return true;
  }
}
