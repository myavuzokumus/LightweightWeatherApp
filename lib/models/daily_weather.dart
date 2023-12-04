import 'dart:math';

import 'weather_info.dart';

class DailyWeather extends WeatherInfo {
  @override
  late int humidity;
  @override
  late int dayTemperature;
  @override
  late int nightTemperature;

  late String day;
  late String dayWeather;
  late String nightWeather;

  DailyWeather(final WeatherInfo city, this.day)
      : super(
            city.city,
            city.currentWeather,
            city.instantTemperature,
            city.dayTemperature,
            city.nightTemperature,
            city.feelsLike,
            city.humidity) {
    // Here the values will be retrieved via API.
    // Random values are currently generated.
    humidity = 50 + Random().nextInt(50);
    dayTemperature = 5 + Random().nextInt(10);
    nightTemperature = 10 + Random().nextInt(10);
    dayWeather = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
    nightWeather = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
  }
}
