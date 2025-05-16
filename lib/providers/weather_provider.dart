import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/weather_model.dart';
import '/services/weather_service.dart';
import 'geolocation_provider.dart';

//simple class to wrap parameters
class WeatherRequest {
  final double lat;
  final double lon;
  final String units;

  const WeatherRequest({
    required this.lat,
    required this.lon,
    this.units = "metric",
  });
}

//uses parameters from WeatherRequest and weather_service to provide weather
final weatherProvider = FutureProvider.family<Weather, WeatherRequest>((ref, request) async {
  return await getWeather(request.lat, request.lon, units: request.units);
});

final localWeatherProvider = FutureProvider<Weather>((ref) async {
  final location = await ref.watch(geolocationProvider.future);
  return await getWeather(location.latitude, location.longitude);
});
