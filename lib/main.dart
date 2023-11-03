import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/pages/addCity.dart';

import 'pages/main_page.dart';

final cityDataBox = Hive.box('selectedCities');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('selectedCities');

  doWhenWindowReady(() {
    const initialSize = Size(500, 700);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "Lightweight Weather App";
    appWindow.show();
  });

/*  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    const WindowOptions windowOptions = WindowOptions(
      minimumSize: Size(500, 700),
      size: Size(500, 700),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
    );

    unawaited(windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    }));
  }
*/

  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        title: "Lightweight Weather App",
        initialRoute: '/',
        routes: {
          '/': (final context) => const WeatherHomePage(),
          '/addCity': (final context) => const AddCity(),
        },
        theme: ThemeData(
          useMaterial3: true,
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
        ),
      ),
    );
  }
}
