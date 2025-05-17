import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/weather_provider.dart';
import '/providers/geolocation_provider.dart';
import '/widgets/weather_tiles.dart';
import '/widgets/hourly_list.dart';
import '/widgets/error_widget.dart';
import '/pages/error_placeholder.dart';

//TODO: split this. it's getting crowded.

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(localWeatherProvider); //load weather data

    return weatherData.when(
      data: (weather) => Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.search), // placeholder
          title: Text(weather.timezone),
        ),
        body: Column(
          children: <Widget>[
            WeatherTiles(weatherData: weather),
            HourlyList(hourlyData: weather.hourly),
          ],
        ),
      ),

      loading: () => Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.search),
          title: Text("Loading..."),
        ),
        body: Center(child: CircularProgressIndicator()),
      ),
      
      error: (e, _) {
          showErrorDialog(
            context,
            e,
            () => ref.invalidate(geolocationProvider),
          );
        return ErrorPlaceholder(function: () => ref.invalidate(geolocationProvider)); //return a placeholder error page
      }
    );
  }
}