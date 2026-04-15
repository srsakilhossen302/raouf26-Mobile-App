import 'package:get/get.dart';

class TrackingPackageModel {
  final String id;
  final String userName;
  final String userImage;
  final double price;
  final String fromCity;
  final String toCity;
  final String fromTime;
  final String toTime;
  final int currentStatusStep; // 0=Booked, 1=Picked Up, 2=In Transit, 3=Delivered
  final String date;
  final String packageSize;
  final String priority;

  TrackingPackageModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.price,
    required this.fromCity,
    required this.toCity,
    required this.fromTime,
    required this.toTime,
    required this.currentStatusStep,
    required this.date,
    required this.packageSize,
    required this.priority,
  });
}

class TransporterTrackingController extends GetxController {
  var isMapView = false.obs;
  var selectedFilterTab = 0.obs;

  final List<String> filterTabs = ["Active", "Picked Up", "In Transit"];

  final packages = <TrackingPackageModel>[
    TrackingPackageModel(
      id: "#PKG-001",
      userName: "Mukaram H.",
      userImage: "https://i.pravatar.cc/150?img=11",
      price: 120.0,
      fromCity: "France",
      toCity: "Germany",
      fromTime: "08:30 AM",
      toTime: "10:45 PM",
      currentStatusStep: 2, // In Transit
      date: "Jan 29, 2026",
      packageSize: "Medium (15kg)",
      priority: "Urgent",
    ),
    TrackingPackageModel(
      id: "#PKG-002",
      userName: "Zain M.",
      userImage: "https://i.pravatar.cc/150?img=12",
      price: 120.0,
      fromCity: "France",
      toCity: "Germany",
      fromTime: "08:30 AM",
      toTime: "10:45 PM",
      currentStatusStep: 0, // Booked
      date: "Jan 29, 2026",
      packageSize: "Small (5kg)",
      priority: "Standard",
    ),
  ].obs;

  void toggleView() {
    isMapView.value = !isMapView.value;
  }

  void setFilterTab(int index) {
    selectedFilterTab.value = index;
  }
}
