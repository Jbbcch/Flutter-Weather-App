import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/weather_provider.dart';
import '/providers/geolocation_provider.dart';
import '/widgets/hourly_list.dart';
import '/widgets/error_widget.dart';

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
            Center(
              child: Text(
                "${weather.current.temp.round()}\u00b0",
                textScaler: TextScaler.linear(5),
              ),
              heightFactor: 2, // spacing
            ),
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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showErrorDialog(
            context,
            e,
            () => ref.invalidate(geolocationProvider),
          );
        });
        return Scaffold(
          appBar: AppBar(
          leading: Icon(Icons.search),
          title: Text("Error"),
        ),
        );
      }
    );
  }
}