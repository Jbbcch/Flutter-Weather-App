import 'package:flutter/material.dart';
import '/models/weather_model.dart';
import '/models/city_model.dart';
import '/widgets/hourly_list.dart';

class WeeklyForecastPage extends StatelessWidget {
  final Weather weatherData;
  final City? city;
  final LinearGradient gradient;

  const WeeklyForecastPage({super.key, required this.weatherData, required this.city, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradient.colors[1],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("${city?.name ?? weatherData.timezone}, ${city?.country ?? ""}"),
            ),
        backgroundColor: gradient.colors[0],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: gradient
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: List<Widget>.generate(7, (int index) {
                Daily day = weatherData.daily[index];
                DateTime date = DateTime.fromMillisecondsSinceEpoch(day.date);
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${Weekdays[date.weekday]}, ${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(IconMap[day.weather.first.icon]),
                          Text(
                            "Max: ${day.temp.max.round()}\u00b0", //max temp
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Min: ${day.temp.min.round()}\u00b0", //min temp
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Rain: ${day.pop.round()}%",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "${(day.windSpeed * 3.6).toStringAsFixed(1)} km/h", //wind speed
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            )
          ),
        ),
      ),
    );
  }
}

final Map<int, String> Weekdays = {
  1 : "Monday",
  2 : "Tuesday",
  3 : "Wednesday",
  4 : "Thursday",
  5 : "Friday",
  6 : "Saturday",
  7 : "Sunday"
};