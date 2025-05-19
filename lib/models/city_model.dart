//city model. used in a list return of cities_service.
import 'dart:convert';

class City {
  final String name;
  final String country;
  final double latitude;
  final double longitude;

  City({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  String toJsonString() {
    Map<String, dynamic> json = {
      'name' : this.name,
      'country' : this.country,
      'latitude' : this.latitude,
      'longitude' : this.longitude
    };
    return jsonEncode(json);
  }
}
