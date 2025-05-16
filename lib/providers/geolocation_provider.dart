import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '/services/geolocation_service.dart';

final geolocationProvider = FutureProvider<Position>((ref) async {
  return await determinePosition();
});