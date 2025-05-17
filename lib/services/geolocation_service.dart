import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

//simple class to wrap coordinates. move this elswhere if needed.
class Coordinates {
  final latitude;
  final longitude;

  Coordinates({required this.latitude, required this.longitude});
}

Future<Coordinates> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      //permission denied, so ask again next time
      return Future.error('Location permissions are denied.');
    }
  }
    
  if (permission == LocationPermission.deniedForever) {
    //permissions are denied forever, handle appropriately.
    //ask to turn them on for current location functionality
    return Future.error('Location permissions are permanently denied, we cannot request permissions.\nOpen app settings and go to permissions.');
  }

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    //service disabled, so get last known location
    final cachedLocation = await _getCachedLocation();
    if (cachedLocation != null) {
      return Coordinates(latitude: cachedLocation.latitude, longitude: cachedLocation.longitude);
    }
    return Future.error('Location services are disabled.' +
      '\nNo last known location.' +
      '\nPlease turn on geolocation and retry.'
    );
  }

  //if this is reached, then the location should be available
  final location = await Geolocator.getCurrentPosition().timeout(
    Duration(seconds: 5),
    //the gps gets confused if turned on mid-runtime. this is here to address that
    //10 seconds is as fast as i could get this to work
    onTimeout: () => Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true
    ).timeout(
      Duration(seconds: 25),
      onTimeout: () => Future.error("GPS service on your device is taking too long")
    ) //this takes longer so only use if gps is stuck
  );

  //cache the location
  _cacheLocation(location.latitude, location.longitude);

  return Coordinates(latitude: location.latitude, longitude: location.longitude);
} 

//fucntion to cache the location
Future<void> _cacheLocation(double lat, double lon) async {
  final prefs = await SharedPreferences.getInstance(); //use shared preferences

  prefs.setDouble('last_lat', lat);
  prefs.setDouble('last_lon', lon);
}

//function to get the cached values if they exist
Future<Coordinates?> _getCachedLocation() async {
  final prefs = await SharedPreferences.getInstance();

  final lat = prefs.getDouble('last_lat');
  final lon = prefs.getDouble('last_lon');

  if (lat != null && lon != null) { //if cache exists return the stored values
    return Coordinates(latitude: lat, longitude: lon);
  }
  return null;
}