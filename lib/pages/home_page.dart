import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/widgets/hourly_list.dart';

class HomePage extends StatelessWidget {
  final Weather weatherData;

  const HomePage({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search), //placeholder, switch to IconButton later
        title: Text(weatherData.timezone), //placeholder, need more precise location
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text(
              "${weatherData.current.temp.round()}\u00b0", //display current temperature
              textScaler: TextScaler.linear(5),
            ),
            heightFactor: 2, //for empty space. replace with padding later
          ),
          HourlyList(hourlyData: weatherData.hourly), //list of hourly weather as a scrollable horizontal list
        ],
      ),
    );
  }
}