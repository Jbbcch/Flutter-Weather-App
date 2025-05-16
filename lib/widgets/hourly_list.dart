import 'package:flutter/material.dart';
import '/models/weather_model.dart';

class HourlyList extends StatelessWidget {
  final List<Current> hourlyData;

  const HourlyList({super.key, required this.hourlyData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List<Widget>.generate(24, (int index) { //generate 24 hour list
          DateTime date = DateTime.fromMillisecondsSinceEpoch(hourlyData[index].date);
          return new Container(
            padding: EdgeInsets.symmetric(horizontal: 5), //for spacing between elements
            child: Column(
              children: <Widget>[
                Text("${date.hour}:00"), //display the forecast time
                Text(
                  "${hourlyData[index].temp.round()}\u00b0", //display temperature in degrees
                  textScaler: TextScaler.linear(1.5),
                ),
              ],
            )
          );
        })
      )
    );
  }
}