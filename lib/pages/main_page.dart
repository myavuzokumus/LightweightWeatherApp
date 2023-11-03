import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import '../models/weather.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {

  static int cityCount = 0;

  @override
  Widget build(final BuildContext context) {

    String lastSelectedCity = cityDataBox.get("lastSelected") ?? "Select City";


    //TODO: City deletion will be added.
    //TODO: App Icon will be added.
    //TODO: Web & Desktop incompatiblity will be fixed.

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        appBar: AppBar(
          flexibleSpace: Container (
            decoration: BoxDecoration (
              gradient: LinearGradient (
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color> [Colors.black.withOpacity(0.7), Colors.transparent]),
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
          backgroundColor: Colors.indigo.withOpacity(0.75),
          child: Column(
            children: [
              Container(
                height: 75,
              ),
              ValueListenableBuilder<Box>(
                valueListenable:
                    Hive.box('selectedCities').listenable(keys: ["cities"]),
                builder: (final BuildContext context,
                    final Box<dynamic> value, final Widget? child) {

                  final List<String>? cities = cityDataBox.get("cities");

                  cityCount = cities?.length ?? 0;

                  return SizedBox(
                    height: cityCount < 11 ? 35 + (cityCount* 50) : 575,
                    child: cities == null ? const Text("No city added yet.") : ListView.builder(
                      itemCount: cities.length,
                      itemExtent: 50,
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      itemBuilder:
                          (final BuildContext context, final int index) {
                        return ListTile(
                          leading: const Icon(
                            Icons.location_city,
                          ),
                          title: Text(cities.elementAt(index)),
                          onTap: () {
                            cityDataBox.put(
                                "lastSelected", cities.elementAt(index));
                            setState(() {
                              lastSelectedCity = cities.elementAt(index);
                              Navigator.pop(context);
                            });
                          },
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
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.inversePrimary,
              Colors.black,
            ],
          )),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                Container(
                  width: 512,
                  margin: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '24°',
                              style: TextStyle(fontSize: 72.spMin),
                            ),
                            Text(
                              'Feels 19°',
                              style: TextStyle(fontSize: 21.spMin),
                            ),
                            Text(
                              '25° / 17°',
                              style: TextStyle(fontSize: 21.spMin),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Lottie.asset('assets/icons/lottie/clear-day.json'),
                      ),
                    ],
                  ),
                ),
                InfoCard()
              ]),
            ),
          ),
        ));
  }
}

class InfoCard extends StatelessWidget {
  InfoCard({super.key});

  static const String day = "Sunday";

  static final List<String> nextDay = nextDays(day: day, nextDay: 6);

  final Weather yesterday = Weather(nextDay.last, 80, 24, 11);

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Card(
        color: Colors.indigo.withOpacity(0.25),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          child: Container(
            width: 275.w,
            height: 250,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Opacity(
                  opacity: 0.7,
                  child: Row(
                    children: [
                      const Expanded(flex: 2, child: Text("Yesterday")),
                      SizedBox(width: 20, child: Text("${yesterday.humidity}")),
                      Lottie.asset("assets/icons/lottie/humidity.json", width: 35, animate: false),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: 30,
                        child: Text("${yesterday.dayTemperature}°"),
                      ),
                      SizedBox(
                        width: 25,
                        child: Text("${yesterday.nightTemperature}°"),
                      ),
                      const SizedBox(width: 15),
                      Lottie.asset(yesterday.dayType, width: 30, animate: false),
                      Lottie.asset(yesterday.nightType, width: 30, animate: false),
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
                        final Weather dayDetails =
                            Weather(nextDay[index], 45, 24, 11);

                        return InkWell(
                          onTap: () {
                            debugPrint('Card tapped.');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                  flex: 2, child: Text(dayDetails.dayName, style: TextStyle(fontWeight: FontWeight.bold))),
                              SizedBox(
                                  width: 20,
                                  child: Text("${dayDetails.humidity}")),
                              Lottie.asset("assets/icons/lottie/humidity.json",
                                  width: 35, animate: false),
                              const SizedBox(width: 15),
                              SizedBox(
                                width: 30,
                                child: Text("${dayDetails.dayTemperature}°"),
                              ),
                              SizedBox(
                                width: 25,
                                child: Text("${dayDetails.nightTemperature}°",),
                              ),
                              const SizedBox(width: 15),
                              Lottie.asset(dayDetails.dayType, width: 30, animate: false),
                              Lottie.asset(dayDetails.nightType, width: 30, animate: false),
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
