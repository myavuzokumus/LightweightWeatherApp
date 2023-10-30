import 'package:flutter/material.dart';
import 'package:weather/pages/addCity.dart';

import 'pages/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  String city = "Test";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      routes: {
        '/': (context) => WeatherHomePage(city: city),
        '/addCity': (context) => const addCity(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),

        ).apply(bodyColor: Colors.white, displayColor: Colors.white),

        useMaterial3: true,
      ),
    );
  }
}
