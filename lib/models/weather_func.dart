import 'package:flutter/material.dart';

final List<String> hours = <String>[
  "00:00",
  "01:00",
  "02:00",
  "03:00",
  "04:00",
  "05:00",
  "06:00",
  "07:00",
  "08:00",
  "09:00",
  "10:00",
  "11:00",
  "12:00",
  "13:00",
  "14:00",
  "15:00",
  "16:00",
  "17:00",
  "18:00",
  "19:00",
  "20:00",
  "21:00",
  "22:00",
  "23:00"
];

final List<String> weekDays = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
];

String getIconOfWeather(final String type, final String hour) {
  final int newHour = int.parse(hour.substring(0,2));
  switch (type) {
    case "Sunny":
      if (newHour > 6 && newHour < 19) {
        return "assets/icons/lottie/clear-day.json";
      } else {
        return "assets/icons/lottie/clear-night.json";
      }
    case "Cloudy":
      return "assets/icons/lottie/cloudy.json";
    case "Rainy":
      return "assets/icons/lottie/overcast-rain.json";
    case "Snowy":
      return "assets/icons/lottie/overcast-snow.json";

    default:
      return "assets/icons/lottie/clear-day.json";
  }
}

List<Color> backgroundColor(final String type) {

  List<Color> result = [];

  switch (type) {
    case "Cloudy":
      return result = [
        const Color(0xFFd4dde8),
        const Color(0xFFd4dde8)
      ];
    case "Rainy":
      return result = [
        const Color(0xFF1b4978),
        const Color(0xFF123252)
      ];
    case "Snowy":
      return result = [
        const Color(0xFF6f747c),
        const Color(0xFF414449)
      ];
    default:
      return result = [
        const Color(0xFF53d0ff),
        const Color(0xFF43a8cd)
      ];
  }
}

String getAnimationOfWeather(final String type, final String hour) {
  final int newHour = int.parse(hour.substring(0,2));
  switch (type) {
    case "Sunny":
      if (newHour > 6 && newHour < 19) {
        return "assets/icons/lottie/clear-day.json";
      } else {
        return "assets/icons/lottie/clear-night.json";
      }
    case "Cloudy":
      return "assets/icons/lottie/cloudy.json";
    case "Rainy":
      return "assets/icons/lottie/overcast-rain.json";
    case "Snowy":
      return "assets/icons/lottie/overcast-snow.json";

    default:
      return "assets/icons/lottie/clear-day.json";
  }
}

String getTime() {
  final String utc = DateTime.now().toString().substring(11, 13);
  final String match = hours.firstWhere((h) => h.substring(0, 2) == utc);
  return match;
}

List<String> nextHours() {
  final int hourNum = DateTime.now().hour;

  final List<String> result = [];

  for (int i = 0; i < 24; i++) {
    result.add(hours[(hourNum + i) % 24]);
  }

  return result;
}

List<String> nextDays({required final int nextDay}) {
  final int dayNum = DateTime.now().weekday;

  final List<String> result = [];

  for (int i = 0; i < nextDay; i++) {
    result.add(weekDays[(dayNum + i + 1) % 7]);
  }

  return result;
}
