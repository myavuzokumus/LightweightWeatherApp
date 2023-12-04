import 'dart:math';
import 'weather_info.dart';

class HourlyWeather extends WeatherInfo {

  String hourTemp;
  late int temperature;
  late String weatherType;

  HourlyWeather(final String city, this.hourTemp) : super(city) {
    // Here the values will be retrieved via API.
    // Random values are currently generated.
    temperature = 10 + Random().nextInt(20);
    weatherType = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
  }
}
