import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Add observables for dashboard data
  final RxString userName = "Zain Malik".obs;
  final RxString userRole = "Ready to Send a Parcel?".obs;
  
  // Stats
  final RxString totalEarnings = "€1,240".obs;
  final RxString clientsCount = "42".obs;

  // Filter options
  final RxString statisticsFilter = "Weekly".obs;
  final RxString earningsFilter = "Weekly".obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch initial data here
  }
}
