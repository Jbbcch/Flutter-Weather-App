import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'compass_widget.dart';
import '/models/weather_model.dart';

class WeatherTiles extends StatelessWidget {
  final Weather weatherData;

  WeatherTiles({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final commonColor = Colors.white.withOpacity(0.1);
    final sunriseTime = DateTime.fromMillisecondsSinceEpoch(weatherData.daily.first.sunrise).toString();
    final sunsetTime = DateTime.fromMillisecondsSinceEpoch(weatherData.daily.first.sunset).toString();
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: 10
      ),
      height: 350, 
      child: Row(
        spacing: 10,
        children: <Widget>[
          Expanded(
            child: Column(
              spacing: 10,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Container(
                        height: 150,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "${weatherData.current.temp.round()}\u00b0",
                              textScaleFactor: 6,
                            ),
                            Text(
                              "${weatherData.current.weather.first.main} " +
                              "${weatherData.daily.first.temp.max.round()}\u00b0/${weatherData.daily.first.temp.min.round()}\u00b0",
                              textScaleFactor: 1.4
                            ),
                          ],
                        ),
                      ),
                    )
                  )
                ),
                Expanded(
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: commonColor,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 70,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Icon(MdiIcons.weatherSunsetUp),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Sunrise: ${sunriseTime.substring(11, 16)}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Icon(MdiIcons.weatherSunsetDown),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Sunset: ${sunsetTime.substring(11, 16)}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      )
                    ),
                  )
                ),
              ],
            )
          ),
          Expanded(
            child: Column(
              spacing: 10,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: commonColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Humidity: ${weatherData.current.humidity}%",
                            textScaleFactor: 1.2,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Pressure: ${weatherData.current.pressure}mbar",
                            textScaleFactor: 1.2,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "UV Index: ${weatherData.current.uvi.round()}",
                            textScaleFactor: 1.2,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Risk of Rain: ${weatherData.current.pop?.round() ?? 0}%",
                            textScaleFactor: 1.2,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Clouds: ${weatherData.current.clouds}%",
                            textScaleFactor: 1.2,
                          ),
                        ),
                        Text(
                          "Visibility Distance: ${weatherData.current.visibility}m",
                          textScaleFactor: 1.2,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                      ],
                    )
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: commonColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${weatherData.current.windDeg}\u00b0",
                                  textScaleFactor: 1.2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Speed:",
                                    textScaleFactor: 1.2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${weatherData.current.windSpeed.toStringAsFixed(1)} km/h",
                                    textScaleFactor: 1.2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        CompassWidget(angle: weatherData.current.windDeg),
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
        ],
      )
    );
  }
}