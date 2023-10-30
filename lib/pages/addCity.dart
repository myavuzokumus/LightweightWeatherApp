import 'package:flutter/material.dart';

class addCity extends StatelessWidget {
  const addCity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(hintText: 'Search city name...'),
        ),
      ),
    );
  }
}
