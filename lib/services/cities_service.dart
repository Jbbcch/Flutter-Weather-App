import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/models/city_model.dart';

final _geodbUrl = Uri.parse("https://wft-geo-db.p.rapidapi.com/v1/geo/cities");

Future<Map<String, dynamic>> _getCitiesJson({
  required String namePrefix, 
  int limit = 10, 
  String types = "CITY", 
  String sort = "-population", 
  String languageCode = "en"
  }) async {
  try {
    final response = await http.get(_geodbUrl.replace(queryParameters: {
        'namePrefix' : namePrefix,
        'limit' : limit.toString(),
        'types' : types,
        'sort' : sort,
        'languageCode' : languageCode,
      }
    ),
    headers: {
        'X-RapidAPI-Key': dotenv.env['CITIES_API_KEY']!,
        'X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com',
      }
    );

    return json.decode(response.body);
  }
  catch(e) {
    return Future.error('Could not reach cities API. Check internet connection.');
  }
}

//get cities as list from json
Future<List<City>> getCities(String query) async {
  final jsonData = await _getCitiesJson(namePrefix: query);
  try {
    final data = jsonData['data'] as List<dynamic>;
    return data.map((e) => City.fromJson(e)).toList();
  }
  catch (e) {
    print("i don't care, cry about it");  //superb error handling
  }
  return [];
}

Future<void> addCityToFavourites(City city) async {
  final cityString = city.toJsonString();
  final prefs = await SharedPreferences.getInstance();
  List<String> saved = prefs.getStringList('favourite_cities') ?? [];

  if (!saved.contains(cityString)) {
    saved.add(cityString);
    await prefs.setStringList('favourite_cities', saved);
  }
}

Future<List<City>> getCityFavourites() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> saved = prefs.getStringList('favourite_cities') ?? [];
  return List.of(saved.map((e) => City.fromJson(jsonDecode(e))));
}