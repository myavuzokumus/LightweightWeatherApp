import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import '../models/daily_weather.dart';
import '../models/hourly_weather.dart';
import '../models/weather_func.dart';
import '../models/weather_info.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

//TODO: Drawer yeniden yapılacak.

class _WeatherHomePageState extends State<WeatherHomePage> {
  String lastSelectedCity = cityDataBox.get("lastSelected") ?? "Select City";



  @override
  Widget build(final BuildContext context) {

    final weatherInfo = WeatherInfo(lastSelectedCity);

    final bool isScreenWide = MediaQuery.of(context).size.width >= 960;

    return Scaffold(
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
      drawer: Drawer(
        width: 275,
        backgroundColor: const Color(0xFF123252).withOpacity(0.75),
        elevation: 10.0,
        child: Column(
          children: [
            Container(
              height: 75,
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
                  height: cityCount < 11 ? 35 + (cityCount * 50) : 575,
                  child: cityCount == 0
                      ? const Text("No city added yet.")
                      : ListView.builder(
                          itemCount: cities.length,
                          itemExtent: 50,
                          itemBuilder:
                              (final BuildContext context, final int index) {
                            final String city = cities.elementAt(index);

                            return Dismissible(
                              key: Key(city),
                              onDismissed: (final direction) async {
                                // Remove the item from the data source.
                                cities.removeAt(index);
                                await cityDataBox.put(
                                    "cities", cities.toList());
                                if (cities.isNotEmpty) {
                                  await cityDataBox.put(
                                      "lastSelected", cities.first);
                                }
                                else {
                                  await cityDataBox.put(
                                      "lastSelected", null);
                                }

                                setState(() {
                                  if (cities.isNotEmpty) {
                                    lastSelectedCity = cities.first;
                                  } else {
                                    lastSelectedCity = "Select City";
                                  }
                                });
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
                                  cityDataBox.put("lastSelected", city);
                                  setState(() {
                                    lastSelectedCity = city;
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            );
                          },
                        ),
                );
              },
            ),
            FilledButton.tonalIcon(
                label: const Text('Add city'),
                onPressed: () {
                  Navigator.pushNamed(context, '/addCity');
                },
                icon: const Icon(Icons.add)),
          ],
        ),
      ),
      body: RefreshIndicator(
        displacement: 75,
        onRefresh: () async {
          setState(() {});

          await Future<void>.delayed(const Duration(seconds: 2));

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Page is reloaded.")));
        },
        child: Stack(
            children: [
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
                ...backgroundColor(weatherInfo.currentWeather)
              ],
            )),
          ),
          Positioned(
            bottom: -125,
            left: -200,
            child: Opacity(
              opacity: 0.25,
              child: Lottie.asset(backgroundSplash(weatherInfo.currentWeather),
                  width: 512),
            ),
          ),
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  margin:
                  EdgeInsets.only(top: 75.h, left: 10.w, right: 10.w, bottom: 20),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(top: 28.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${weatherInfo.instantTemperature}°',
                                  style: TextStyle(fontSize: 58.spMin, height: 1),
                                ),
                                Text(
                                  weatherInfo.currentWeather,
                                  style:
                                  TextStyle(fontSize: 24.spMin, height: 1.5),
                                ),
                                Text(
                                  '${weatherInfo.dayTemperature}° / ${weatherInfo.nightTemperature}°'
                                      '\nFeels like ${weatherInfo.feelsLike}°',
                                  style: TextStyle(
                                      fontSize: 14.spMin,
                                      color: Colors.white.withOpacity(0.7)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Lottie.asset(
                              getIconOfWeather(
                                  weatherInfo.currentWeather, "09:00"),
                              width: 256),
                        ),
                      ],
                    ),
                    Flex(
                      crossAxisAlignment: isScreenWide
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      direction: isScreenWide ? Axis.horizontal : Axis.vertical,
                      children: [
                        DailyStatusCard(
                          weatherInfo: weatherInfo,
                        ),
                        if (isScreenWide)
                          const SizedBox(width: 25)
                        else
                          const SizedBox(width: 0),
                        NextDaysCard(weatherInfo: weatherInfo),
                      ],
                    )
                  ]),
                ),
              ),
        ]),
      ),
    );
  }
}

class DailyStatusCard extends StatelessWidget {
  DailyStatusCard({required this.weatherInfo, super.key});

  final WeatherInfo weatherInfo;

  final List<String> nextHour = nextHours();

  final String currentTime = getTime();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(final BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(hours.indexOf(currentTime).toDouble() * 76,
            duration: const Duration(seconds: 1), curve: Curves.easeOut);
      }
    });

    return Container(
      width: 425,
      height: 150,
      margin: EdgeInsets.only(top: 25.h, bottom: 5.h),
      child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: hours.length,
          itemBuilder: (final BuildContext context, final int index) {
            final HourlyWeather hourDetails = weatherInfo.hour(hours[index]);

            return Card(
              shadowColor: Colors.black, // gölge rengi
              color: Colors.indigo.withOpacity(0.25),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                  splashColor: Colors.white.withAlpha(30),
                  onTap: () {},
                  child: Container(
                    width: 75,
                    padding: const EdgeInsets.all(3),
                    color: currentTime == hours[index]
                        ? Colors.indigo.shade300
                        : Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(hours[index]),
                        Lottie.asset(getIconOfWeather(
                            hourDetails.weatherType, hours[index])),
                        Text("${hourDetails.temperature}°"),
                      ],
                    ),
                  )),
            );
          }),
    );
  }
}

class NextDaysCard extends StatelessWidget {
  NextDaysCard({required this.weatherInfo, super.key});

  final WeatherInfo weatherInfo;

  final List<String> nextDay = nextDays(nextDay: 6);

  @override
  Widget build(final BuildContext context) {
    final DailyWeather yesterday = weatherInfo.day(nextDay.last);

    return Center(
      child: Card(
        shadowColor: Colors.black, // gölge rengi
        color: Colors.indigo.withOpacity(0.25),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          child: Container(
            width: 425,
            height: 250,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Opacity(
                  opacity: 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("Yesterday",
                              style: TextStyle(fontSize: 16.spMin))),
                      Text("${yesterday.humidity}",
                          style: TextStyle(fontSize: 16.spMin)),
                      Lottie.asset("assets/icons/lottie/humidity.json",
                          width: 35.spMin, animate: false),
                      SizedBox(width: 6.w),
                      SizedBox(
                        width: 75.spMin,
                        child: Text(
                            "${yesterday.dayTemperature}° / ${yesterday.nightTemperature}°",
                            style: TextStyle(fontSize: 16.spMin)),
                      ),
                      SizedBox(width: 5.w),
                      Lottie.asset(
                          getIconOfWeather(yesterday.dayWeather, "09:00"),
                          width: 30.spMin,
                          animate: false),
                      Lottie.asset(
                          getIconOfWeather(yesterday.nightWeather, "19:00"),
                          width: 30.spMin,
                          animate: false),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder:
                          (final BuildContext context, final int index) {
                        final DailyWeather dayDetails =
                            weatherInfo.day(nextDay[index]);

                        return InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Redirecting to site about that day's weather information...")));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Text(nextDay[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.spMin))),
                              Text("${dayDetails.humidity}",
                                  style: TextStyle(fontSize: 16.spMin)),
                              Lottie.asset("assets/icons/lottie/humidity.json",
                                  width: 35.spMin, animate: false),
                              SizedBox(width: 5.w),
                              SizedBox(
                                width: 75.spMin,
                                child: Text(
                                    "${dayDetails.dayTemperature}° / ${dayDetails.nightTemperature}°",
                                    style: TextStyle(fontSize: 16.spMin)),
                              ),
                              SizedBox(width: 5.w),
                              Lottie.asset(
                                  getIconOfWeather(
                                      dayDetails.dayWeather, "09:00"),
                                  width: 30.spMin,
                                  animate: false),
                              Lottie.asset(
                                  getIconOfWeather(
                                      dayDetails.nightWeather, "19:00"),
                                  width: 30.spMin,
                                  animate: false),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
