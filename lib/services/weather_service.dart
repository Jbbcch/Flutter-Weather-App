import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//TODO: add null checks to the API responses in methods

class WeatherService {
    static final _weatherMapUrl = Uri.parse("https://api.openweathermap.org/data/3.0/onecall"); //constant url for the api's address

    static Future<Map<String, dynamic>> _getJson(double lat, double lon, String? apiKey, {String units = "metric", String? exclude}) async {
        var response = await http.get(_weatherMapUrl.replace(queryParameters: { //get the json from api
            'lat' : lat.toString(),
            'lon' : lon.toString(),
            'units' : units, //can be metric or imperial
            'exclude' : exclude, //pass the exclusions (available params: minutely, current, hourly, daily, alerts)
            'appid' : apiKey, //pass the api key
        }));

        return jsonDecode(response.body); //transform data to weather model (see weather_model.dart)
    }

    static Future<Weather> getWeather(double lat, double lon, String? apiKey, {String units = "metric"}) async {
        final json = await _getJson(lat, lon, apiKey, exclude: "minutely");
        return Weather.fromJson(json);
    }

    static Future<Current> getCurrentWeather(double lat, double lon, String? apiKey, {String units = "metric"}) async {
        final json = await _getJson(lat, lon, apiKey, exclude: "minutely, hourly, daily");
        return Current.fromJson(json["current"]);
    }

    static Future<List<Current>> getHourlyWeather(double lat, double lon, String? apiKey, {String units = "metric"}) async {
        final json = await _getJson(lat, lon, apiKey, exclude: "minutely, current, daily");
        print(json["hourly"]);
        return List<Current>.from(json["hourly"].map((e) => Current.fromJson(e)));
    }

    static Future<List<Daily>> getDailyWeather(double lat, double lon, String? apiKey, {String units = "metric"}) async {
        final json = await _getJson(lat, lon, apiKey, exclude: "minutely, hourly, current");
        return List<Daily>.from(json["daily"].map((e) => Daily.fromJson(e)));
    }
}