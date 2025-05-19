import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/services/cities_service.dart';
import '/models/city_model.dart';

final citySearchProvider = FutureProvider.family<List<City>, String>((ref, query) {
  return getCities(query);
});
