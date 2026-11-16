import '../models/openingHour.dart';

class Restaurant {
  final int id;
  final String name;
  final String image;
  final String place;
  final String phone;
  final String description;
  final List<OpeningHour> openingHours;

  const Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.place,
    required this.phone,
    required this.description,
    required this.openingHours,
  });
}