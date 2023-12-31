import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lightweightweather/data_service.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../models/weather_func.dart';
import '../models/weather_info.dart';
import 'main_page_widgets/hourly_status_card.dart';
import 'main_page_widgets/next_days_card.dart';
import 'main_page_widgets/weather_title.dart';

final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  late WeatherInfo weatherInfo;
  late final GlobalKey<RefreshIndicatorState> refreshKey;
  final String currentTime = getTime();

  late Future<Map<String, dynamic>> returnedJsonData;

  @override
  void initState() {
    refreshKey = GlobalKey<RefreshIndicatorState>();

    /*
    Future.delayed(const Duration(milliseconds: 200)).then((final _) {
      refreshKey.currentState?.show();
    });
  */

    //Refresh page when page fully load
    SchedulerBinding.instance.addPostFrameCallback((final _) {
      refreshKey.currentState?.show();
    });

    if (lastSelectedCity != "Select City") {
      returnedJsonData = DataService().getCityWeatherInfo(lastSelectedCity);
    } else {
      returnedJsonData = Future.value({});
    }

    super.initState();
  }

  Future<void> refreshCityInfo() async {

    if (lastSelectedCity != "Select City") {
      returnedJsonData = DataService().getCityWeatherInfo(lastSelectedCity);
    } else {
      returnedJsonData = Future.value({});
    }

    await returnedJsonData;

    setState(() {});

    WidgetsBinding.instance.addPostFrameCallback((final timeStamp) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Page is reloaded.")));
    });

  }

  @override
  Widget build(final BuildContext context) {

    final bool isScreenWide = MediaQuery.of(context).size.width >= 960;

    return Scaffold(
      key: drawerKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        leading: Builder(
          builder: (final BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: 'Open City list',
            );
          },
        ),

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: <Color>[
                  Colors.black.withOpacity(0.7),
                  Colors.transparent
                ]),
          ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text(lastSelectedCity)),
      ),
      drawer: sidebar(context),
      body: RefreshIndicator(
        key: refreshKey,
        displacement: 75,
        onRefresh: refreshCityInfo,
        child: FutureBuilder(
          future: returnedJsonData,
          builder: (final BuildContext context,
              final AsyncSnapshot<Map<String, dynamic>> snapshot) {

            if (snapshot.hasData) {
              final Map<String, dynamic> returnedJsonData = snapshot.data!;

              snapshot.data!.isNotEmpty
                  ? weatherInfo = WeatherInfo.fromMap(returnedJsonData)
                  : weatherInfo =
                      WeatherInfo(lastSelectedCity, "Sunny", 0, 0, 0, 0, 0);

              return Stack(children: [
                Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.05, 0.15, 0.6, 0.85],
                    colors: [
                      Colors.blue.shade100,
                      Colors.blue.shade300,
                      ...backgroundColor(
                          weatherInfo.currentWeather, currentTime)
                    ],
                  )),
                ),
                Positioned(
                  bottom: -125,
                  left: -200,
                  child: Opacity(
                    opacity: 0.25,
                    child: Lottie.asset(
                        getAnimationOfWeather(
                            weatherInfo.currentWeather, currentTime),
                        width: 512),
                  ),
                ),
                SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      margin:
                          EdgeInsets.only(top: 75.h, left: 10.w, right: 10.w),
                      child: Column(children: <Widget>[
                        WeatherTitle(
                            weatherInfo: weatherInfo, currentTime: currentTime),
                        Flex(
                          crossAxisAlignment: isScreenWide
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          direction:
                              isScreenWide ? Axis.horizontal : Axis.vertical,
                          children: [
                            if (snapshot.data!.isNotEmpty)
                              HourlyStatusCard(
                                weatherInfo: weatherInfo,
                                currentTime: currentTime,
                                returnedJsonData: returnedJsonData,
                              ),
                            if (isScreenWide)
                              const SizedBox(width: 25)
                            else
                              const SizedBox(width: 0),
                            NextDaysCard(
                                weatherInfo: weatherInfo,
                                returnedJsonData: returnedJsonData),
                          ],
                        )
                      ]),
                    ))
              ]);
            } else {
              return Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                      margin:
                          EdgeInsets.only(top: 75.h, left: 10.w, right: 10.w),
                      child: const Text("Connection failed to the server.")),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Drawer sidebar(final BuildContext context) {
    return Drawer(
      width: 275,
      backgroundColor: const Color(0xFF123252).withOpacity(0.75),
      elevation: 10.0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Cities',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ValueListenableBuilder<Box>(
            valueListenable:
                Hive.box('selectedCities').listenable(keys: ["cities"]),
            builder: (final BuildContext context, final Box<dynamic> value,
                final Widget? child) {
              final List<String> cities =
                  cityDataBox.get("cities") ?? <String>[];

              final int cityCount = cities.length;

              return SizedBox(
                height: cityCount < 9 ? (cityCount == 0 ? 20 : ((cityCount + 0.5) * 60)) : 510,
                child: cityCount == 0
                    ? const Text("No city added yet.")
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cities.length,
                        itemBuilder:
                            (final BuildContext context, final int index) {
                          final String city = cities.elementAt(index);

                          return Dismissible(
                            key: Key(city),
                            onDismissed: (final direction) async {
                              // Remove the item from the data source.
                              cities.removeAt(index);
                              await cityDataBox.put("cities", cities.toList());
                              if (cities.isNotEmpty) {
                                await cityDataBox.put(
                                    "lastSelected", cities.first);
                              } else {
                                await cityDataBox.put("lastSelected", null);
                              }

                              if (city == lastSelectedCity) {
                                if (cities.isNotEmpty) {
                                  lastSelectedCity = cities.first;
                                } else {
                                  lastSelectedCity = "Select City";
                                }

                                unawaited(refreshKey.currentState?.show());
                              }
                            },
                            // Show a red background as the item is swiped away.
                            background: Container(color: Colors.red),

                            child: ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              leading: const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Icon(
                                  Icons.location_city,
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(city),
                              ),
                              selectedColor: Colors.green.shade200,
                              selected: lastSelectedCity == city,
                              onTap: () {
                                Navigator.pop(context);
                                if (lastSelectedCity != city) {
                                  cityDataBox.put("lastSelected", city);
                                  lastSelectedCity = city;
                                  refreshKey.currentState?.show();
                                }
                              },
                            ),
                          );
                        }, separatorBuilder: (final BuildContext context, final int index) { return const SizedBox(height: 5); },
                      ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          FilledButton.tonalIcon(
              label: const Text('Add city'),
              onPressed: () async {
                final returnedCity = await Navigator.pushNamed(context, '/addCity');
                final List<String> cities =
                    cityDataBox.get("cities") ?? <String>[];
                if (cities.length == 1) {
                  lastSelectedCity = (returnedCity! as String);
                  await cityDataBox.put("lastSelected", lastSelectedCity);
                  unawaited(refreshKey.currentState?.show());
                }
              },
              icon: const Icon(Icons.add)),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    final Uri url =
                    Uri.parse('https://www.visualcrossing.com/weather-data');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  child: Column(
                    children: [
                      const Text("Weather data provided by"),
                      Image.asset("assets/data_provider/visualcrossing.png",
                          width: 196),
                    ],
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
