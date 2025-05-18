import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/pages/weekly_page.dart';

import '/providers/weather_provider.dart';
import '/providers/geolocation_provider.dart';
import '/widgets/weather_tiles.dart';
import '/widgets/hourly_list.dart';
import '/widgets/error_widget.dart';
import '/pages/error_placeholder.dart';
import '/models/gradients.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(localWeatherProvider); //load weather data

    return weatherData.when(
      data: (weather) {
        final weatherType = weather.current.weather.first.main;
        final gradient = weatherGradients[weatherType] ?? weatherGradients['Default']!;

        return Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.search),
            title: Text(weather.timezone),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(gradient: gradient),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    WeatherTiles(weatherData: weather),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WeeklyForecastPage(weatherData: weather))
                      ),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Weekly Forecast",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    HourlyList(hourlyData: weather.hourly),
                  ],
                ),
              ),
            ),
          ),
        );
      },

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
        return ErrorPlaceholder(function: () => ref.invalidate(geolocationProvider));
      },
    );
  }
}