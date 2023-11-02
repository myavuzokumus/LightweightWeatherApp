class Weather {

  Weather(
      this.dayName, this.humidity, this.dayTemperature, this.nightTemperature
      );

  String dayName;
  int humidity;
  int dayTemperature;
  int nightTemperature;

  String dayType = 'assets/icons/lottie/clear-day.json';
  String nightType = 'assets/icons/lottie/clear-night.json';

}


List<String> nextDays({required final String day, required final int nextDay}) {

  final List<String> weekDays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  final int dayIndex = weekDays.indexOf(day);

  List<String> result = [];

  for (int i = 0; i < nextDay; i++) {
    result.add(weekDays[(dayIndex + i + 1) % 7]);
  }

  return result;
}

