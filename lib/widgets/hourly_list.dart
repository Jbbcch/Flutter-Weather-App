import 'package:flutter/material.dart';
import '/models/weather_model.dart';

class HourlyList extends StatelessWidget {
  final List<Current> hourlyData;

  const HourlyList({super.key, required this.hourlyData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16)
        ),
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10
        ),
        height: 100,
        child: Center(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List<Widget>.generate(24, (int index) { //generate 24 hour list
              DateTime date = DateTime.fromMillisecondsSinceEpoch(hourlyData[index].date);
              final supposedIcon = hourlyData[index].weather.first.icon;
              return new Container(
                padding: EdgeInsets.symmetric(horizontal: 5), //for spacing between elements
                child: Column(
                  children: <Widget>[
                    Text(
                      "${hourlyData[index].temp.round()}\u00b0", //display temperature in degrees
                      textScaler: TextScaler.linear(1.5),
                    ),
                    Icon(IconMap[supposedIcon]), //gets the icon from icon map
                    Text("${date.hour}:00"), //display the forecast time
                  ],
                )
              );
            })
          ),
        )
      )
    );
  }
}

//map for all icons
final Map<String, IconData> IconMap = {
  '01d': Icons.wb_sunny,    //clear sky (day)
  '01n': Icons.nights_stay, //clear sky (night)
  '02d': Icons.wb_cloudy,   //few clouds (day)
  '02n': Icons.nights_stay, //few clouds (night)
  '03d': Icons.cloud,       //scattered clouds (day)
  '03n': Icons.cloud,       //scattered clouds (night)
  '04d': Icons.cloud_queue, //broken clouds (day)
  '04n': Icons.cloud_queue, //broken clouds (night)
  '09d': Icons.grain,       //shower rain (day)
  '09n': Icons.grain,       //shower rain (night)
  '10d': Icons.umbrella,    //rain (day)
  '10n': Icons.umbrella,    //rain (night)
  '11d': Icons.flash_on,    //thunderstorm (day)
  '11n': Icons.flash_on,    //thunderstorm (night)
  '13d': Icons.ac_unit,     //snow (day)
  '13n': Icons.ac_unit,     //snow (night)
  '50d': Icons.blur_on,     //mist (day)
  '50n': Icons.blur_on,     //mist (night)
};