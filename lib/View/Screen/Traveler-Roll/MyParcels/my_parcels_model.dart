class MyParcelsModel {
  final String id;
  final String name;
  final String status;

  MyParcelsModel({required this.id, required this.name, required this.status});

  factory MyParcelsModel.fromJson(Map<String, dynamic> json) {
    return MyParcelsModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}
