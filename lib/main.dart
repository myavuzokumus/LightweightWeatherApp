import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/pages/add_city.dart';

import 'pages/main_page.dart';

final cityDataBox = Hive.box('selectedCities');
String lastSelectedCity = cityDataBox.get("lastSelected") ?? "Select City";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('selectedCities');
  //await dotenv.load(fileName: ".env");

  if (defaultTargetPlatform != TargetPlatform.iOS &&
      defaultTargetPlatform != TargetPlatform.android &&
      !kIsWeb) {
    doWhenWindowReady(() {
      const initialSize = Size(500, 700);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.title = "Lightweight Weather App";
      appWindow.show();
    });
  }

  runApp(const WeatherAppMain());
}

class WeatherAppMain extends StatelessWidget {
  const WeatherAppMain({super.key});

  @override
  Widget build(final BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      ensureScreenSize: true,
      child: MaterialApp(
        title: "Lightweight Weather App",
        initialRoute: '/',
        routes: {
          '/': (final context) => const WeatherHomePage(),
          '/addCity': (final context) => const AddCity(),
        },
        scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        }),
        theme: ThemeData(
          fontFamily: 'Product Sans',
          useMaterial3: true,
          listTileTheme: const ListTileThemeData(
              textColor: Colors.white, iconColor: Colors.white),
          iconTheme: const IconThemeData(color: Colors.white),
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 28),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
            titleLarge: TextStyle(color: Colors.white),
          ).apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
    );
  }
}
