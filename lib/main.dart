import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather_app/services/weather_service.dart'; //service to fetch json data and transform it to model
import 'package:flutter_weather_app/services/geolocation_service.dart' as geo; //service to fetch device location
import 'package:flutter_weather_app/pages/home_page.dart';

void main() async{
  await dotenv.load(); //load the .env file with api key
  var location = await geo.determinePosition();
  final weather = await WeatherService.getWeather(location.latitude, location.longitude, dotenv.env['API_KEY']);
  runApp(WeatherApp(weatherData: weather,));
}

class WeatherApp extends StatelessWidget {
  final weatherData;
  const WeatherApp({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) { //calling the constructor automatically initiates build()
    return MaterialApp(
      home: HomePage(weatherData: weatherData)
    );
  }
} 