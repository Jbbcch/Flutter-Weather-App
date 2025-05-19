import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/services/cities_service.dart';
import '/models/city_model.dart';

final cityFavouritesProvider = FutureProvider<List<City>>((ref) async {
  return await getCityFavourites();
});

