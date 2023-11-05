/*class WeatherInfo {
  WeatherInfo({required this.cityName});

  String cityName;

  late int humidity = 0;

  late int dayTemperature = 0;
  late int nightTemperature = 0;

  late String dayType = 'assets/icons/lottie/clear-day.json';
  late String nightType = 'assets/icons/lottie/clear-night.json';


}*/

// HavaDurumu classı tanımlanıyor
import 'dart:math';

import 'daily_weather.dart';
import 'hourly_weather.dart';

class WeatherInfo {

  String city;
  late int instantTemperature;
  late int dayTemperature;
  late int nightTemperature;
  late int humidity;
  late int feelsLike;
  late String currentWeather;


  WeatherInfo(this.city) {
    // Here the values will be retrieved via API.
    // Random values are currently generated.
    instantTemperature = 10 + Random().nextInt(20);
    feelsLike = 5 + Random().nextInt(20);
    dayTemperature = 5 + Random().nextInt(10);
    nightTemperature = 10 + Random().nextInt(10);
    humidity = 50 + Random().nextInt(50);
    currentWeather = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
  }

  // Day method is defined
  // This method returns a DailyWeather class containing that day's weather information
  DailyWeather day(final String day) {
    return DailyWeather(city, day);
  }

  // Hour method is defined
  // This method returns an HourlyWeather class containing the weather information for that hour
  HourlyWeather hour(final String hour) {
    return HourlyWeather(city, hour);
  }
}
