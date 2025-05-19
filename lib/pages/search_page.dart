import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


import '/models/city_model.dart';
import '/providers/cities_provider.dart';
import '/providers/weather_provider.dart';
import '/services/cities_service.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
      ),
      body: TypeAheadField<City>(
        debounceDuration: Duration(milliseconds: 500),
        itemBuilder: (context, city) {
          return ListTile(
            title: Text('${city.name}, ${city.country}'),
          );
        }, 
        suggestionsCallback: (pattern) async {
          if (pattern.length < 2) return [];
          return await getCities(pattern);
        },
        onSelected: (city) {
          ref.read(locationRequestProvider.notifier).state = WeatherRequest(lat: city.latitude, lon: city.longitude);
        },
      )
    );
  }
}