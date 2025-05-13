import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather_app/services/weather_service.dart'; //service to fetch json data and transform it to model
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/services/geolocation_service.dart'; //model to store json data

void main() async{
  await dotenv.load(); //load the .env file with api key
  var location = await determinePosition();
  final weather = await WeatherService.getWeather(location.latitude, location.longitude, dotenv.env['API_KEY']);
  final date = DateTime.fromMillisecondsSinceEpoch(weather.current.date);
  print(date);
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) { //calling the constructor automatically initiates build()
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Weather App"),
          backgroundColor: Colors.cyan,
        ),
        /*add body:
          this has to be a multi-page app
          create pages in /pages and add simple display functionality to them
          then rewrite this file accordingly to support said pages
          through a menu / dropdown / button / left-right swipe. the method you choose doesn't matter too much
          since we still have to decide how exactly the page navigation should be implemented so don't bother right now
        */
      ),
    );
  }
} 