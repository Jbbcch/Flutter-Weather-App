import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/models/weather_model.dart';

//TODO: add null checks to the API responses

final _weatherMapUrl = Uri.parse("https://api.openweathermap.org/data/3.0/onecall"); //constant url for the api's address

Future<Map<String, dynamic>> _getJson({required double lat, required double lon, String units = "metric", String? exclude}) async {
    var response = await http.get(_weatherMapUrl.replace(queryParameters: { //get the json from api
        'lat' : lat.toString(),
        'lon' : lon.toString(),
        'units' : units, //can be metric or imperial
        'exclude' : exclude, //pass the exclusions (available params: minutely, current, hourly, daily, alerts). null-safe
        'appid' : dotenv.env['API_KEY'], //pass the api key
    }));
    return jsonDecode(response.body) as Map<String, dynamic>; //transform data to weather model (see weather_model.dart)
}

Future<Weather> getWeather(double lat, double lon, {String units = "metric"}) async {
    final json = await _getJson(lat: lat, lon: lon, exclude: "minutely");
    return Weather.fromJson(json);
}
