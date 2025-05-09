import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
    static final _weatherMapUrl = Uri.parse("https://api.openweathermap.org/data/3.0/onecall"); //constant url for the api's address

    static Future<Weather> getWeather(double lat, double lon, String? apiKey, {String? exclude}) async {
        var response = await http.get(_weatherMapUrl.replace(queryParameters: { //get the json from api
            'lat' : lat.toString(),
            'lon' : lon.toString(),
            'units' : "metric", //metric units by default and NOT CONFIGURABLE, fuck imperial
            'exclude' : exclude, //pass the exclusions (might use this later on. NULL-SAFE so nice to have either way)
            'appid' : apiKey, //pass the api key
        }));

        return weatherFromJson(response.body); //transform data to weather model (see weather_model.dart)
    }
}