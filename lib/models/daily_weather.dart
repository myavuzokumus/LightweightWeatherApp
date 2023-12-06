import 'weather_info.dart';

class DailyWeather extends WeatherInfo {

  @override
  final int humidity;
  @override
  final int dayTemperature;
  @override
  final int nightTemperature;

  final DateTime day;
  final String dayWeather;
  final String nightWeather;

  DailyWeather(final WeatherInfo city, this.day, this.dayWeather, this.nightWeather, this.dayTemperature, this.nightTemperature, this.humidity)
      : super(
            city.city,
            city.currentWeather,
            city.instantTemperature,
            city.dayTemperature,
            city.nightTemperature,
            city.feelsLike,
            city.humidity);


  DailyWeather.fromMap(final WeatherInfo city, final Map<String, dynamic> map) : this(
    city,
    DateTime.parse(map['date']),
    map['dayWeather'],
    map['nightWeather'],
    map['dayTemperature'],
    map['nightTemperature'],
    map['humidity'],
  );


  /*
      // Here the values will be retrieved via API.
    // Random values are currently generated.
    humidity = 50 + Random().nextInt(50);
    dayTemperature = 5 + Random().nextInt(10);
    nightTemperature = 10 + Random().nextInt(10);
    dayWeather = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
    nightWeather = ["Sunny", "Cloudy", "Rainy", "Snowy"][Random().nextInt(4)];
   */
}
