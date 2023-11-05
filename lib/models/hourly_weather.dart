import 'dart:math';
import 'weather_info.dart';

class HourlyWeather extends WeatherInfo {

  String hourTemp;
  late int temperature;
  late String weatherType;

  // Yapıcı metod tanımlanıyor
  HourlyWeather(final String city, this.hourTemp) : super(city) {
    // Şehir ve saate göre hava durumu bilgileri alınıyor
    // Bu kısım gerçek bir API kullanarak yapılabilir
    // Burada basitçe rasgele değerler atıyorum
    temperature = 10 + Random().nextInt(20);
    weatherType = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
  }
}