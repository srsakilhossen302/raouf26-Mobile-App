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

  factory TrackingPackageModel.fromJson(Map<String, dynamic> json) {
    return TrackingPackageModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      userImage: json['userImage'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      fromCity: json['fromCity'] ?? '',
      toCity: json['toCity'] ?? '',
      fromTime: json['fromTime'] ?? '',
      toTime: json['toTime'] ?? '',
      currentStatusStep: json['currentStatusStep'] ?? 0,
      date: json['date'] ?? '',
      packageSize: json['packageSize'] ?? '',
      priority: json['priority'] ?? '',
    );
  }
}

class TransporterTrackingController extends GetxController {
  var isMapView = false.obs;
  var selectedFilterTab = 0.obs;

  final List<String> filterTabs = ["active", "picked_up", "in_transit", "delivered_status"];

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
      priority: "urgent",
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
      currentStatusStep: 1, // Picked Up
      date: "Jan 29, 2026",
      packageSize: "Small (5kg)",
      priority: "standard",
    ),
    TrackingPackageModel(
      id: "#PKG-003",
      userName: "Sarah J.",
      userImage: "https://i.pravatar.cc/150?img=13",
      price: 150.0,
      fromCity: "Tunisia",
      toCity: "Italy",
      fromTime: "10:00 AM",
      toTime: "06:30 PM",
      currentStatusStep: 3, // Delivered
      date: "Jan 28, 2026",
      packageSize: "Large (25kg)",
      priority: "urgent",
    ),
    TrackingPackageModel(
      id: "#PKG-004",
      userName: "Ahmed S.",
      userImage: "https://i.pravatar.cc/150?img=14",
      price: 90.0,
      fromCity: "France",
      toCity: "Spain",
      fromTime: "09:00 AM",
      toTime: "08:00 PM",
      currentStatusStep: 0, // Booked/Active
      date: "Jan 30, 2026",
      packageSize: "Medium (10kg)",
      priority: "standard",
    ),
  ].obs;

  void toggleView() {
    isMapView.value = !isMapView.value;
  }

  void setFilterTab(int index) {
    selectedFilterTab.value = index;
  }

  List<TrackingPackageModel> get filteredPackages {
    return packages.where((pkg) => pkg.currentStatusStep == selectedFilterTab.value).toList();
  }
}
