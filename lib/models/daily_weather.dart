import 'dart:math';

import 'weather_info.dart';

class DailyWeather extends WeatherInfo {

  String dayTemp;
  @override
  late int humidity;
  @override
  late int dayTemperature;
  @override
  late int nightTemperature;
  late String dayWeather;
  late String nightWeather;

  DailyWeather(final String city, this.dayTemp) : super(city) {
    // Here the values will be retrieved via API.
    // Random values are currently generated.
    humidity = 50 + Random().nextInt(50);
    dayTemperature = 5 + Random().nextInt(10);
    nightTemperature = 10 + Random().nextInt(10);
    dayWeather = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
    nightWeather = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
  }
}