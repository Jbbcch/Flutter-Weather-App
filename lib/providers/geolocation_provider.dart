import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/services/geolocation_service.dart';

final geolocationProvider = FutureProvider<Coordinates>((ref) async {
  return await determinePosition();
});