import 'package:get/get.dart';

class TransporterHomeController extends GetxController {
  final RxString totalEarnings = "€1,240".obs;
  final RxString activeClients = "1,240".obs;
  final RxString rating = "4.8".obs;

  final RxList<RequestModel> newRequests = <RequestModel>[
    RequestModel(
      from: "Tunis",
      to: "Paris",
      price: "€25",
      date: "14 Jan",
      time: "2:30 PM",
      userName: "Ahmed B.",
      userImage: "https://i.pravatar.cc/150?img=11",
    ),
    RequestModel(
      from: "Tunis",
      to: "Paris",
      price: "€25",
      date: "14 Jan",
      time: "2:30 PM",
      userName: "Ahmed B.",
      userImage: "https://i.pravatar.cc/150?img=12",
    ),
  ].obs;

  final RxList<DeliveryModel> activeDeliveries = <DeliveryModel>[
    DeliveryModel(
      pkgId: "#PKG-001",
      status: "In Transit",
      route: "Paris \u2022 2 days",
      userName: "Ahmed B.",
      userImage: "https://i.pravatar.cc/150?img=11",
    ),
    DeliveryModel(
      pkgId: "#PKG-002",
      status: "Delivered",
      route: "Paris \u2022 2 days",
      userName: "Ahmed B.",
      userImage: "https://i.pravatar.cc/150?img=12",
    ),
  ].obs;
}

class RequestModel {
  final String from;
  final String to;
  final String price;
  final String date;
  final String time;
  final String userName;
  final String userImage;

  RequestModel({
    required this.from,
    required this.to,
    required this.price,
    required this.date,
    required this.time,
    required this.userName,
    required this.userImage,
  });
}

class DeliveryModel {
  final String pkgId;
  final String status;
  final String route;
  final String userName;
  final String userImage;

  DeliveryModel({
    required this.pkgId,
    required this.status,
    required this.route,
    required this.userName,
    required this.userImage,
  });
}
