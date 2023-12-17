import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../data_service.dart';
import '../main.dart';

class AddCity extends StatefulWidget {
  const AddCity({super.key});

  @override
  State<AddCity> createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  TextEditingController searchTextController = TextEditingController();

  List<String> cities = cityDataBox.get("cities") ?? <String>[];

  List<String> predictedList = <String>[];

  int foundedCityCount = 0;

  late final String uuid;

  @override
  void initState() {
    super.initState();
     uuid = const Uuid().v4();
  }

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
          autofocus: true,
          controller: searchTextController,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(hintText: 'Search city name...'),
          onChanged: (final value) async {
            predictedList = await DataService().getSuggestion(value, uuid);
            setState(() {});
          },
        ),
      ),
      body: ListView.builder(
        itemCount: predictedList.length,
        itemBuilder: (final BuildContext context, final int index) {

          final String stateCity = predictedList[index];

          return ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Text(stateCity,
                  style: const TextStyle(color: Colors.black)),
            ),
            onTap: () async {
              if (cities.contains(stateCity)) {
                unawaited(showDialog<String>(
                  context: context,
                  builder: (final BuildContext context) => AlertDialog(
                    title: const Text("City can't be added."),
                    content: const Text("The city already added.",
                        style: TextStyle(color: Colors.indigo)),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('Ok'),
                      ),
                    ],
                  ),
                ));
              } else {
                await cityDataBox.put("cities", <String>[
                  ...cities,
                  stateCity
                ]);
                if (mounted) {
                  Navigator.pop(context, true);
                }
              }
            },
          );
        },
      ),
    );
  }
}
