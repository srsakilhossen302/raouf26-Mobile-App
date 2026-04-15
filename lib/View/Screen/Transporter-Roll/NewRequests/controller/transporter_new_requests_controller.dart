import 'package:get/get.dart';

class NewRequestModel {
  final String id;
  final String userName;
  final String userImage;
  final String timeAgo;
  final String status;
  final String fromCity;
  final String fromDate;
  final String fromTime;
  final String toCity;
  final String toDate;
  final String toTime;
  final String packageSize;
  final String packageStatus;
  final double totalEstimate;
  final List<String> packagePhotos;

  NewRequestModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.timeAgo,
    required this.status,
    required this.fromCity,
    required this.fromDate,
    required this.fromTime,
    required this.toCity,
    required this.toDate,
    required this.toTime,
    required this.packageSize,
    required this.packageStatus,
    required this.totalEstimate,
    this.packagePhotos = const [],
  });

  // Example factory for fetching from API later
  factory NewRequestModel.fromJson(Map<String, dynamic> json) {
    return NewRequestModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      userImage: json['userImage'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      status: json['status'] ?? '',
      fromCity: json['fromCity'] ?? '',
      fromDate: json['fromDate'] ?? '',
      fromTime: json['fromTime'] ?? '',
      toCity: json['toCity'] ?? '',
      toDate: json['toDate'] ?? '',
      toTime: json['toTime'] ?? '',
      packageSize: json['packageSize'] ?? '',
      packageStatus: json['packageStatus'] ?? '',
      totalEstimate: (json['totalEstimate'] ?? 0).toDouble(),
      packagePhotos: List<String>.from(json['packagePhotos'] ?? []),
    );
  }
}

class TransporterNewRequestsController extends GetxController {
  // Mock data ready to be replaced by API calls mapped to NewRequestModel.fromJson
  final requests = <NewRequestModel>[
    NewRequestModel(
      id: "req_1",
      userName: "Ahmad B.",
      userImage: "https://i.pravatar.cc/150?img=11",
      timeAgo: "5 hrs ago",
      status: "Pending",
      fromCity: "Tunis",
      fromDate: "14 Jan",
      fromTime: "08:30 AM",
      toCity: "Paris",
      toDate: "14 Jan",
      toTime: "10:45 PM",
      packageSize: "Medium (15kg)",
      packageStatus: "Urgent",
      totalEstimate: 25.0,
      packagePhotos: [
        "https://picsum.photos/200/200?random=1",
        "https://picsum.photos/200/200?random=2"
      ],
    ),
    NewRequestModel(
      id: "req_2",
      userName: "Sarah M.",
      userImage: "https://i.pravatar.cc/150?img=12",
      timeAgo: "2 hrs ago",
      status: "Pending",
      fromCity: "Alger",
      fromDate: "15 Jan",
      fromTime: "09:00 AM",
      toCity: "Marseille",
      toDate: "15 Jan",
      toTime: "02:00 PM",
      packageSize: "Small (5kg)",
      packageStatus: "Standard",
      totalEstimate: 15.0,
      packagePhotos: [
        "https://picsum.photos/200/200?random=3"
      ],
    ),
  ].obs;
}
