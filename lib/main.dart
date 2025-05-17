import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/home_page.dart';

void main() async{
  await dotenv.load(); //load the .env file with api key
  runApp(ProviderScope(
    child: WeatherApp(),
  ));
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) { //calling the constructor automatically initiates build()
    return MaterialApp(
      //TODO: move theme elsewhere
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueAccent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          titleTextStyle: TextStyle(
            fontSize: 24,
            color: Colors.white
          )
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white
          )
        )
      ),
      home: HomePage(),
    );
  }
} 