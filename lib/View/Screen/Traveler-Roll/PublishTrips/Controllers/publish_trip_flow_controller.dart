import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/trip_model.dart';
import 'package:raouf26mobileapp/Utils/custom_snackbar.dart';

class PublishTripFlowController extends GetxController {
  final RxInt currentStep = 0.obs;
  final RxBool isEditMode = false.obs;
  final RxBool isFromDetailsScreen = false.obs;
  final RxInt targetStep = 0.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<DateTime?> returnDate = Rx<DateTime?>(null);
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
  final RxString pricePerDocumentText = "".obs;
  final RxString pricePerPackageText = "".obs;
  final RxBool canCarryDocuments = false.obs;
  final RxBool canCarryPackages = true.obs;
  final capacityController = TextEditingController();
  final RxString capacityText = "".obs;

  // Travel Details
  final RxString selectedTravelMode = "".obs;
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

  final RxString travelDetailsSummary = "".obs;

  void updateTravelDetailsSummary() {
    if (selectedTravelMode.value.isEmpty) {
      travelDetailsSummary.value = "";
      return;
    }
    String details = selectedTravelMode.value;
    switch (selectedTravelMode.value) {
      case "Flight":
        if (flightNumberController.text.isNotEmpty) {
          details += ", ${flightNumberController.text}";
        } else if (selectedAirline.value != "Select Airline") {
          details += ", ${selectedAirline.value}";
        }
        break;
      case "Car":
        if (selectedVehicleType.value != "Select Vehicle Type") {
          details += ", ${selectedVehicleType.value}";
        }
        if (licensePlateController.text.isNotEmpty) {
          details += " (${licensePlateController.text})";
        }
        break;
      case "Train":
        if (trainNumberController.text.isNotEmpty) {
          details += ", ${trainNumberController.text}";
        }
        break;
      case "Bus":
        if (busNumberController.text.isNotEmpty) {
          details += ", ${busNumberController.text}";
        }
        break;
      case "Boat":
        if (vesselNameController.text.isNotEmpty) {
          details += ", ${vesselNameController.text}";
        }
        break;
      case "Other":
        if (otherDescriptionController.text.isNotEmpty) {
          details += ", ${otherDescriptionController.text}";
        }
        break;
    }
    travelDetailsSummary.value = details;
  }

  void nextStep() {
    if (currentStep.value == 3) {
      updateTravelDetailsSummary();
    }
    
    if (isEditMode.value) {
      if (isFromDetailsScreen.value) {
        // If we are at Price step (2), go to Travel Details (3) next instead of returning immediately
        if (currentStep.value == 2) {
          currentStep.value = 3;
          return;
        }
        Get.back(); // Go back to TripDetailsScreen from other steps (like 3 or 1)
        isEditMode.value = false;
        isFromDetailsScreen.value = false;
        return;
      }
      currentStep.value = 6; // Go back to Review & Publish
      isEditMode.value = false;
      return;
    }

    if (currentStep.value == 0) {
      currentStep.value = 5; // Go to Trip Rules & Details
    } else if (currentStep.value == 1 || currentStep.value == 2 || currentStep.value == 3) {
      currentStep.value = 0; // Return to main page with data
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
    returnDate.value = null;
  }

  bool validateTrip() {
    // 1. Check Date
    if (selectedDate.value == null) {
      CustomSnackbar.error(title: "Error", message: "Please select a travel date.");
      return false;
    }

    // 2. Check Departure & Destination
    if (departureController.text.isEmpty ||
        destinationController.text.isEmpty) {
      CustomSnackbar.error(title: "Error", message: "Please provide both departure and destination cities.");
      return false;
    }

    // 3. Check Travel Times
    if (departureTime.value.isEmpty || arrivalTime.value.isEmpty) {
      CustomSnackbar.error(title: "Error", message: "Please set your departure and arrival times.");
      return false;
    }

    // 4. Check Capacity
    if (capacityController.text.isEmpty) {
      CustomSnackbar.error(title: "Error", message: "Please specify the suitcase capacity.");
      return false;
    }

    // 5. Check Pricing
    if (!canCarryDocuments.value && !canCarryPackages.value) {
      CustomSnackbar.error(
          title: "Error",
          message: "Please select at least one item type (Packages or Documents).",
      );
      return false;
    }

    if (canCarryDocuments.value && pricePerDocumentController.text.isEmpty) {
      CustomSnackbar.error(title: "Error", message: "Please set a price for document delivery.");
      return false;
    }

    if (canCarryPackages.value && pricePerPackageController.text.isEmpty) {
      CustomSnackbar.error(title: "Error", message: "Please set a price per kg for package delivery.");
      return false;
    }

    return true;
  }
}
