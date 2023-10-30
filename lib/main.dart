import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/pages/addCity.dart';

import 'pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('city');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String city = "Test";

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
        listTileTheme: const ListTileThemeData(
            textColor: Colors.white,
            iconColor: Colors.white
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 28
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
        ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.white
        ),
        useMaterial3: true,
      ),
    );
  }
}
