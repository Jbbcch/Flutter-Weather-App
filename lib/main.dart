import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'package:flutter_weather_app/models/weather_model.dart';

//this is a TEST VERSION, i know the code is shit

void main() async{
  await dotenv.load(); //load the .env file with api key
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) { //make this less horrible
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Weather App"),
          backgroundColor: Colors.cyan,
        ),
        body: FutureBuilder<Weather>( //add exception handling
          future: WeatherService.getWeather(40.409264, 49.867092, dotenv.env['API_KEY']), //load the weather data from Baku
          builder:(context, snapshot) {
            Weather? weatherData = snapshot.data; //actually get the data when recieved
            return Center(child: Text("Current temperature in Baku: ${weatherData?.current.temp}C")); //simple display of current temperature for now
          },
        ),
      ),
    );
  }
}