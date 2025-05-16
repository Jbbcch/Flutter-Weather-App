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
      home: HomePage(),
    );
  }
} 