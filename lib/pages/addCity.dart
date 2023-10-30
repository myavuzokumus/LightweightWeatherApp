import 'package:flutter/material.dart';

class addCity extends StatelessWidget {
  const addCity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(hintText: 'Search city name...', ),
        ),
      ),
    );
  }
}
