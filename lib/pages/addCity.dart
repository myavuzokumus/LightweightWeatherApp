import 'package:flutter/material.dart';

import '../main.dart';

class AddCity extends StatefulWidget {
  const AddCity({super.key});

  @override
  State<AddCity> createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {

  TextEditingController searchTextController = TextEditingController();

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
            });
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder:
          (final BuildContext context, final int index) {
            return ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Text(searchTextController.text,
                    style: const TextStyle(color: Colors.black)),
                ),
                onTap: () async {
                  await cityDataBox.put("cities", <String>[...?cityDataBox.get("cities"), searchTextController.text]);
                  Navigator.pop(context, true);
                },
            );
      },),
    );
  }
}
