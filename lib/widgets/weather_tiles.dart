import 'package:flutter/material.dart';
import '/models/weather_model.dart';

class WeatherTiles extends StatelessWidget {
  final Weather weatherData;

  WeatherTiles({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final commonColor = Colors.white.withOpacity(0.2);
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: 10,
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
                      color: commonColor,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Center(
                      child: Text(
                        "${weatherData.current.temp.round()}\u00b0",
                        textScaleFactor: 6, //depricated. replace.
                      ),
                    )
                  )
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: commonColor,
                      borderRadius: BorderRadius.circular(16)
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
                      borderRadius: BorderRadius.circular(16)
                    ),
                  )
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: commonColor,
                      borderRadius: BorderRadius.circular(16)
                    ),
                  )
                ),
              ],
            )
          ),
        ],
      )
    );
  }
}