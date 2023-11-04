import 'dart:async';

import 'package:flutter/material.dart';

import '../main.dart';

class AddCity extends StatefulWidget {
  const AddCity({super.key});

  @override
  State<AddCity> createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  TextEditingController searchTextController = TextEditingController();

  List<String> cities = cityDataBox.get("cities") ?? <String>[];

  int foundedCityCount = 0;

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: TextField(
          controller: searchTextController,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(hintText: 'Search city name...'),
          onChanged: (final value) {
            setState(() {
              searchTextController.text.isNotEmpty
                  ? foundedCityCount = 5
                  : foundedCityCount = 0;
            });
          },
        ),
      ),
      body: ListView.builder(
        itemCount: foundedCityCount,
        itemBuilder: (final BuildContext context, final int index) {
          return ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Text(searchTextController.text,
                  style: const TextStyle(color: Colors.black)),
            ),
            onTap: () async {
              if (cities.contains(searchTextController.text)) {
                unawaited(showDialog<String>(
                  context: context,
                  builder: (final BuildContext context) => AlertDialog(
                    title: const Text("City can't be added."),
                    content: const Text("The city already added.",
                        style: TextStyle(color: Colors.indigo)),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ));
              } else {
                await cityDataBox.put("cities", <String>[
                  ...?cityDataBox.get("cities"),
                  searchTextController.text
                ]);
                Navigator.pop(context, true);
              }
            },
          );
        },
      ),
    );
  }
}
