import 'package:geolocator/geolocator.dart';

//TODO: add fallbacks for errors using last known location

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  //test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    //handle this by asking to turn them on and restart the app, maybe
    //or use last known location
    return Future.error('Location services are disabled.');
  }

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
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  } 

  //if this is reached, then the location should be available
  return await Geolocator.getCurrentPosition();
}