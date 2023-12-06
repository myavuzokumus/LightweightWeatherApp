import 'weather_info.dart';

class HourlyWeather extends WeatherInfo {

  final String hourTemp;
  final int temperature;
  final String weatherType;

  HourlyWeather(final WeatherInfo city, this.hourTemp, this.temperature, this.weatherType) : super(
      city.city,
      city.currentWeather,
      city.instantTemperature,
      city.dayTemperature,
      city.nightTemperature,
      city.feelsLike,
      city.humidity);

  HourlyWeather.fromMap(final WeatherInfo city, final Map<String, dynamic> map) : this(
      city,
      map['hour'],
      map['temperature'],
      map['weatherType'],
  );
}
