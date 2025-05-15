import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_model.dart';

class HomePage extends StatelessWidget {
  final Weather weatherData;

  const HomePage({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search), //placeholder, switch to IconButton later
        title: Text(weatherData.timezone),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text(
              "${weatherData.current.temp.round()}\u00b0",
              textScaler: TextScaler.linear(5),
              style: TextStyle(fontFamily: ""),
            ),
            heightFactor: 2,
          ),
        ],
      ),
    );
  }
}