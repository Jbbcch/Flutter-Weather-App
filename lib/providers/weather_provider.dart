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

//watch its state to determine whether a request is passed or not
final locationRequestProvider = StateProvider<WeatherRequest?>((ref) => null);

//uses two other providers and a weather request provider to determine which method to use
final adaptiveWeatherProvider = FutureProvider<Weather>((ref) {
  final locationRequest = ref.watch(locationRequestProvider);
  
  if (locationRequest == null) {
    return ref.watch(localWeatherProvider.future);
  } else {
    return ref.watch(locationWeatherProvider(locationRequest).future);
  }
});

//uses parameters from WeatherRequest and weather_service to provide weather
final locationWeatherProvider = FutureProvider.family<Weather, WeatherRequest>((ref, request) async {
  return await getWeather(request.lat, request.lon, units: request.units);
});

final localWeatherProvider = FutureProvider<Weather>((ref) async {
  final location = await ref.watch(geolocationProvider.future);
  return await getWeather(location.latitude, location.longitude);
});
