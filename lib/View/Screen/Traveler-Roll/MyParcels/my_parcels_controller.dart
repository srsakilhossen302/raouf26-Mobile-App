import 'package:get/get.dart';

class MyParcelsController extends GetxController {
  final RxInt selectedFilter = 0.obs;
  final RxList<String> filters = <String>[
    "All",
    "Active",
    "Delivered",
    "Cancelled",
  ].obs;

  final RxList<Map<String, dynamic>> allParcels = <Map<String, dynamic>>[
    {
      "name": "Ahmed Bin Salah",
      "date": "Thu 20 Jan, 2026",
      "status": "In Transit",
      "statusStep": 2,
      "from": "Tunisia",
      "to": "France",
      "price": "2.5 TND/ kg",
      "total": "37.50 TND",
      "isDelivered": false,
      "isCancelled": false,
    },
    {
      "name": "Ahmed Bin Salah",
      "date": "Thu 20 Jan, 2026",
      "status": "Delivered",
      "statusStep": 3,
      "from": "Tunisia",
      "to": "France",
      "price": "2.5 TND/ kg",
      "total": "37.50 TND",
      "isDelivered": true,
      "isCancelled": false,
    },
    {
      "name": "John Doe",
      "date": "Mon 15 Feb, 2026",
      "status": "Booked",
      "statusStep": 0,
      "from": "USA",
      "to": "Canada",
      "price": "10.0 USD/ kg",
      "total": "150.00 USD",
      "isDelivered": false,
      "isCancelled": false,
    },
    {
      "name": "Sara Khan",
      "date": "Fri 10 Mar, 2026",
      "status": "Cancelled",
      "statusStep": -1,
      "from": "UK",
      "to": "UAE",
      "price": "5.0 GBP/ kg",
      "total": "100.00 GBP",
      "isDelivered": false,
      "isCancelled": true,
    },
  ].obs;

  List<Map<String, dynamic>> get filteredParcels {
    switch (selectedFilter.value) {
      case 0: // All
        return allParcels;
      case 1: // Active
        return allParcels.where((p) => !p['isDelivered'] && !p['isCancelled']).toList();
      case 2: // Delivered
        return allParcels.where((p) => p['isDelivered']).toList();
      case 3: // Cancelled
        return allParcels.where((p) => p['isCancelled']).toList();
      default:
        return allParcels;
    }
  }

  void updateFilter(int index) {
    selectedFilter.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch parcels here
  }
}
