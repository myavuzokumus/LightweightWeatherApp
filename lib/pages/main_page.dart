import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../main.dart';



class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  @override
  Widget build(final BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final int cityCount = cityDataBox.get("cities").first.length ?? 0;

    String lastSelectedCity = cityDataBox.get("lastSelected") ?? "Select City";

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.17),
            child: Text(lastSelectedCity),
          ),
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.5,
          backgroundColor: Colors.indigo.withOpacity(0.75),
          child: Column(
            children: [
              Container(
                height: 75,
              ),
              SizedBox(
                height: cityCount < 11 ? 35 + (cityCount * 50) : 575,
                child: ValueListenableBuilder<Box>(
                  valueListenable: Hive.box('selectedCities').listenable(keys: ["cities"]),
                  builder: (final BuildContext context, final Box<dynamic> value, final Widget? child) {

                    List<String> cities = value.values.first;

                    return ListView.builder(
                      itemCount:  cities.length,
                      itemExtent: 50,
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      itemBuilder: (final BuildContext context, final int index) {
                        return ListTile(
                          leading: const Icon(
                            Icons.location_city,
                          ),
                          title: Text(cities.elementAt(index)),
                          onTap: () {
                            cityDataBox.put("lastSelected", cities.elementAt(index));
                            setState(() {
                              lastSelectedCity = cities.elementAt(index);
                              Navigator.pop(context);
                            });
                          },
                        );
                      },
                    );

                  },
                ),
              ),
              FilledButton.tonalIcon(
                  label: const Text('Şehir ekle!'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/addCity');
                  },
                  icon: const Icon(Icons.add)
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.inversePrimary,
              Colors.black,
            ],
          )),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '24°',
                              style: TextStyle(fontSize: 72),
                            ),
                            Text(
                              'Feels 19°',
                              style: TextStyle(fontSize: 21),
                            ),
                            Text(
                              '25° / 17°',
                              style: TextStyle(fontSize: 21),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                          child: Image(image: AssetImage('assets/sun.gif')))
                    ],
                  ),
                ),
                const InfoCard()
              ])),
        ));
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Card(
        color: Colors.indigo.withOpacity(0.25),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: SizedBox(
            width: 350,
            height: 175,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, right: 6.0, left: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("DayName"),
                      Text("Moisture"),
                      Text("DayTime"),
                      Text("NightTime "),
                      Text("1."),
                      Text("2.")
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder:
                          (final BuildContext context, final int index) {
                        return const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("DayName"),
                            Text("Moisture"),
                            Text("DayTime"),
                            Text("NightTime "),
                            Text("1."),
                            Text("2.")
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
