import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transporter {
  final String name;
  final String imageUrl;
  final double rating;
  final int totalTrips;
  final String vehicleType;
  final String from;
  final String to;
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String toTime;
  final String pricePerKg;
  final String estimatedTotal;
  final List<String> alsoTravelingTo;
  final bool isVerified;

  Transporter({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.totalTrips,
    required this.vehicleType,
    required this.from,
    required this.to,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.pricePerKg,
    required this.estimatedTotal,
    required this.alsoTravelingTo,
    this.isVerified = true,
  });
}

class TransportersController extends GetxController {
  final RxString selectedFilter = "All".obs;
  final List<String> filters = ["All", "Most Trips", "Top Rated"];

  // Filter BottomSheet States
  final RxBool isTravelerSelected = true.obs;
  final RxBool isTransporterSelected = false.obs;
  final RxString selectedCurrency = "TND".obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<RangeValues> priceRange = const RangeValues(2, 10).obs;
  final RxBool isDirectOnly = true.obs;
  final RxBool isAllowStops = false.obs;
  final RxBool isPassingOtherCountries = false.obs;
  final RxBool isStorageRequired = true.obs;
  final RxBool isNoStorageNeeded = false.obs;

  void resetFilters() {
    isTravelerSelected.value = true;
    isTransporterSelected.value = false;
    selectedCurrency.value = "TND";
    selectedDate.value = null;
    priceRange.value = const RangeValues(2, 10);
    isDirectOnly.value = true;
    isAllowStops.value = false;
    isPassingOtherCountries.value = false;
    isStorageRequired.value = true;
    isNoStorageNeeded.value = false;
  }

  final List<Transporter> transporters = [
    Transporter(
      name: "Ahmed Bin Salah",
      imageUrl: "https://randomuser.me/api/portraits/men/1.jpg",
      rating: 4.8,
      totalTrips: 154,
      vehicleType: "Utility Van",
      from: "Tunisia",
      to: "France",
      fromDate: "20 Jan",
      toDate: "20 Jan",
      fromTime: "08:30 AM",
      toTime: "10:45 PM",
      pricePerKg: "2.5 TND/ kg",
      estimatedTotal: "37.50 TND",
      alsoTravelingTo: ["Italy", "Switzerland"],
    ),
    Transporter(
      name: "Mourad Ferjani",
      imageUrl: "https://randomuser.me/api/portraits/men/2.jpg",
      rating: 4.9,
      totalTrips: 320,
      vehicleType: "Utility Van",
      from: "Tunisia",
      to: "Germany",
      fromDate: "20 Jan",
      toDate: "20 Jan",
      fromTime: "08:30 AM",
      toTime: "10:45 PM",
      pricePerKg: "3 TND/ kg",
      estimatedTotal: "45.00 TND",
      alsoTravelingTo: ["Austria", "Poland"],
    ),
  ];

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }
}
