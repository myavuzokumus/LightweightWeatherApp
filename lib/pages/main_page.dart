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
                  end: Alignment.bottomCenter,
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
          backgroundColor: Colors.indigo.withOpacity(0.75),
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
                  final List<String> cities = cityDataBox.get("cities") ?? <String>[];

                  cityCount = cities.length;

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
                                    await cityDataBox.put("cities", cities.toList());
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
                                  selectedColor: Colors.amberAccent,
                                  selected:
                                      lastSelectedCity == city,
                                  onTap: () {
                                    cityDataBox.put(
                                        "lastSelected", city);
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
                      margin: EdgeInsets.only(
                          top: 50.h, left: 20, right: 20, bottom: 20),
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
                            child: Lottie.asset(
                                'assets/icons/lottie/clear-day.json'),
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
            width: 325.w,
            height: 250,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Opacity(
                  opacity: 0.7,
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text("Yesterday", style: TextStyle(fontSize: 16.spMin))),
                      Text("${yesterday.humidity}", style: TextStyle(fontSize: 16.spMin)),
                      Lottie.asset("assets/icons/lottie/humidity.json",
                          width: 35.spMin, animate: false),
                      SizedBox(width: 10.spMin),
                      SizedBox(
                        width: 70.spMin,
                        child: Text("${yesterday.dayTemperature}° / ${yesterday.nightTemperature}°", style: TextStyle(fontSize: 16.spMin)),
                      ),
                      SizedBox(width: 10.spMin),
                      Lottie.asset(yesterday.dayType,
                          width: 30.spMin, animate: false),
                      Lottie.asset(yesterday.nightType,
                          width: 30.spMin, animate: false),
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

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                content: Text("Redirecting to site about that day's weather information...")
                                )
                            );

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Text(dayDetails.dayName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 16.spMin))),
                              Text("${dayDetails.humidity}", style: TextStyle(fontSize: 16.spMin)),
                              Lottie.asset("assets/icons/lottie/humidity.json",
                                  width: 35.spMin, animate: false),
                              SizedBox(width: 10.spMin),
                              SizedBox(
                                width: 70.spMin,
                                child: Text("${dayDetails.dayTemperature}° / ${dayDetails.nightTemperature}°", style: TextStyle(fontSize: 16.spMin)),
                              ),
                              SizedBox(width: 10.spMin),
                              Lottie.asset(dayDetails.dayType,
                                  width: 30.spMin, animate: false),
                              Lottie.asset(dayDetails.nightType,
                                  width: 30.spMin, animate: false),
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
