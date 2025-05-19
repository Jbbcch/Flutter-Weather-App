import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/providers/weather_provider.dart';

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
      body: TextButton(
        onPressed: () {
          ref.read(locationRequestProvider.notifier).state = 
          WeatherRequest(lat: 55.755825, lon: 37.617298);
          Navigator.pop(context);
        },
        child: Text("Get Test Location")
      ),
    );
  }
}