import 'dart:math';

import 'weather_info.dart';

class DailyWeather extends WeatherInfo {
  // Özellikler tanımlanıyor
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
    // Şehir ve güne göre hava durumu bilgileri alınıyor
    // Bu kısım gerçek bir API kullanarak yapılabilir
    // Burada basitçe rasgele değerler atıyorum
    humidity = 50 + Random().nextInt(50);
    dayTemperature = 5 + Random().nextInt(10);
    nightTemperature = 10 + Random().nextInt(10);
    dayWeather = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
    nightWeather = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
  }
}