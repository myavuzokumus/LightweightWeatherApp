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
    // Şehre göre hava durumu bilgileri alınıyor
    // Bu kısım gerçek bir API kullanarak yapılabilir
    // Burada basitçe rasgele değerler atıyorum
    instantTemperature = 10 + Random().nextInt(20);
    feelsLike = 5 + Random().nextInt(20);
    dayTemperature = 5 + Random().nextInt(10);
    nightTemperature = 10 + Random().nextInt(10);
    humidity = 50 + Random().nextInt(50);
    currentWeather = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
  }

  // Day metodu tanımlanıyor
  // Bu metod, o günün hava durumu bilgilerini içeren bir GunlukHavaDurumu classı döndürüyor
  DailyWeather day(final String day) {
    return DailyWeather(city, day);
  }

  // Hour metodu tanımlanıyor
  // Bu metod, o saatin hava durumu bilgilerini içeren bir SaatlikHavaDurumu classı döndürüyor
  HourlyWeather hour(final String hour) {
    return HourlyWeather(city, hour);
  }
}