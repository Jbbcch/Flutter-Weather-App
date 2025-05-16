import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/weather_provider.dart';
import '/widgets/hourly_list.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(localWeatherProvider); //load weather data

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search), //placeholder, switch to IconButton later
        title: weatherData.when(
          data: (weather) => Text(weather.timezone),
          loading: () => const Text("Loading..."),
          error: (e, _) => const Text("Error"),
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: weatherData.when(
              data: (weather) => Text(
                "${weather.current.temp.round()}\u00b0",
                textScaler: TextScaler.linear(5),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => const Text("Failed to load temperature"),
            ),
            heightFactor: 2, //for empty space. replace with padding later
          ),
          weatherData.when(
            data: (weather) => HourlyList(hourlyData: weather.hourly),
            loading: () => const Center(child: Text("Loading hourly data...")),
            error: (e, _) => const Text("Hourly data unavailable"),
          ), //list of hourly weather as a scrollable horizontal list
        ],
      ),
    );
  }
}