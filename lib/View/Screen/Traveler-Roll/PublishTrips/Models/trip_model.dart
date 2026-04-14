class TripModel {
  final String id;
  final String departureCity;
  final String arrivalCity;
  final String departureDate;
  final String arrivalDate;
  final String departureTime;
  final String arrivalTime;
  final String stops;
  final String maxWeight;
  final String pricePerKg;
  final String travelMode;
  final String status;

  TripModel({
    required this.id,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureDate,
    required this.arrivalDate,
    required this.departureTime,
    required this.arrivalTime,
    required this.stops,
    required this.maxWeight,
    required this.pricePerKg,
    required this.travelMode,
    this.status = "Active",
  });
}
