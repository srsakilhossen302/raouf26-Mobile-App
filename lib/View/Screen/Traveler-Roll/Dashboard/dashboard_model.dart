class DashboardModel {
  // Define Dashboard data structure
  final String id;
  final String title;

  DashboardModel({required this.id, required this.title});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      id: json['id'],
      title: json['title'],
    );
  }
}
