//import 'dart:math';

import 'daily_weather.dart';
import 'hourly_weather.dart';

class WeatherInfo {

  final String city;
  final int instantTemperature;
  final int dayTemperature;
  final int nightTemperature;
  final int humidity;
  final int feelsLike;
  final String currentWeather;

  WeatherInfo(this.city, this.currentWeather, this.instantTemperature, this.dayTemperature, this.nightTemperature, this.feelsLike, this.humidity);

  /*{
    // Here the values will be retrieved via API.
    // Random values are currently generated.
    instantTemperature = 10 + Random().nextInt(20);
    feelsLike = 5 + Random().nextInt(20);
    dayTemperature = 5 + Random().nextInt(10);
    nightTemperature = 10 + Random().nextInt(10);
    humidity = 50 + Random().nextInt(50);
    currentWeather = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
  }*/

  WeatherInfo.fromMap(final Map<String, dynamic> map) : this(
      map['city'],
      map['currentWeather'],
      map['instantTemperature'],
      map['dayTemperature'],
      map['nightTemperature'],
      map['feelsLike'],
      map['humidity']
  );

  // Day method is defined
  // This method returns a DailyWeather class containing that day's weather information
  DailyWeather dailyInfo(final String day) {
    return DailyWeather(this, day);
  }

  // Hour method is defined
  // This method returns an HourlyWeather class containing the weather information for that hour
  HourlyWeather hourlyInfo(final String hour) {
    return HourlyWeather(this, hour);
  }
}
