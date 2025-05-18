import 'package:flutter/material.dart';

//list of possible values of weather.main provided by openweathermap docs
final Map<String, LinearGradient> weatherGradients = {
  "Thunderstorm": LinearGradient(
    colors: [Colors.deepPurple, Colors.black87],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  "Drizzle": LinearGradient(
    colors: [Colors.blueGrey.shade300, Colors.blueGrey.shade600],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  "Rain": LinearGradient(
    colors: [Colors.blue.shade700, Colors.indigo.shade900],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  "Snow": LinearGradient(
    colors: [Colors.white, Colors.blueGrey.shade100],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  "Mist": LinearGradient(
    colors: [Colors.grey.shade400, Colors.grey.shade600],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  "Smoke": LinearGradient(
    colors: [Colors.grey.shade500, Colors.grey.shade800],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  "Haze": LinearGradient(
    colors: [Colors.grey.shade300, Colors.grey.shade500],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  "Dust": LinearGradient(
    colors: [Colors.brown.shade200, Colors.brown.shade400],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  "Fog": LinearGradient(
    colors: [Colors.grey.shade300, Colors.grey.shade600],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  "Sand": LinearGradient(
    colors: [Colors.orange.shade200, Colors.brown.shade300],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  "Ash": LinearGradient(
    colors: [Colors.grey.shade700, Colors.black87],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  "Squall": LinearGradient(
    colors: [Colors.blueGrey.shade600, Colors.indigo.shade900],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  "Tornado": LinearGradient(
    colors: [Colors.grey.shade800, Colors.black],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  "Clear": LinearGradient(
    colors: [Colors.lightBlueAccent, Colors.blue],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  "Clouds": LinearGradient(
    colors: [Colors.grey.shade300, Colors.blueGrey],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Default fallback
  "Default": LinearGradient(
    colors: [Colors.blueGrey, Colors.indigo],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
};