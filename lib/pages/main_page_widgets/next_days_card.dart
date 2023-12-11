import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../main.dart';
import '../../models/daily_weather.dart';
import '../../models/weather_func.dart';
import '../../models/weather_info.dart';
import '../main_page.dart';

class NextDaysCard extends StatefulWidget {
  const NextDaysCard({required this.weatherInfo, super.key, required this.returnedJsonData});

  final WeatherInfo weatherInfo;
  final Map<String, dynamic> returnedJsonData;

  @override
  State<NextDaysCard> createState() => _NextDaysCardState();
}

class _NextDaysCardState extends State<NextDaysCard> {

  late List<String> nextDay;

  late DailyWeather yesterday;

  late List<DailyWeather> dayDetails;

  List<DailyWeather> getDailyData() {

    return widget.returnedJsonData["daily"].map<DailyWeather>( (final value) => widget.weatherInfo.dailyInfo(value)).toList();

  }

  @override
  void initState() {

    if (lastSelectedCity != "Select City") {
      dayDetails = getDailyData();
      nextDay = nextDays(nextDay: 6, currentDay: dayDetails[1].day);
      yesterday = dayDetails[0];
    }

    super.initState();
  }

  @override
  Widget build(final BuildContext context) {

    if (refreshState == true && lastSelectedCity != "Select City") {
      setState(() {
        dayDetails = getDailyData();
        nextDay = nextDays(nextDay: 6, currentDay: dayDetails[1].day);
        yesterday = dayDetails[0];
        refreshState = false;
      });
    }

    return Center(
      child: Card(
        shadowColor: Colors.black,
        color: Colors.indigo.withOpacity(0.25),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          child: Container(
            width: 425,
            height: 250,
            padding: const EdgeInsets.all(12),
            child: lastSelectedCity == "Select City" ? Center(child: Text("Select City", style: TextStyle(fontSize: 24.spMin))) :
            Column(
              children: [
                Opacity(
                  opacity: 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("Yesterday",
                              style: TextStyle(fontSize: 16.spMin))),
                      Text("${yesterday.humidity}",
                          style: TextStyle(fontSize: 16.spMin)),
                      Lottie.asset("assets/icons/lottie/humidity.json",
                          width: 35.spMin, animate: false),
                      SizedBox(width: 6.w),
                      SizedBox(
                        width: 75.spMin,
                        child: Text(
                            "${yesterday.dayTemperature}° / ${yesterday.nightTemperature}°",
                            style: TextStyle(fontSize: 16.spMin)),
                      ),
                      SizedBox(width: 5.w),
                      Lottie.asset(
                          getAnimationOfWeather(yesterday.dayWeather, "09:00"),
                          width: 30.spMin,
                          animate: false),
                      Lottie.asset(
                          getAnimationOfWeather(yesterday.nightWeather, "19:00"),
                          width: 30.spMin,
                          animate: false),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder:
                          (final BuildContext context, final int index) {

                        DailyWeather dayData = dayDetails[index + 2];

                        return InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Redirecting to site about that day's weather information...")));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Text(nextDay[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.spMin))),
                              Text("${dayData.humidity}",
                                  style: TextStyle(fontSize: 16.spMin)),
                              Lottie.asset("assets/icons/lottie/humidity.json",
                                  width: 35.spMin, animate: false),
                              SizedBox(width: 5.w),
                              SizedBox(
                                width: 75.spMin,
                                child: Text(
                                    "${dayData.dayTemperature}° / ${dayData.nightTemperature}°",
                                    style: TextStyle(fontSize: 16.spMin)),
                              ),
                              SizedBox(width: 5.w),
                              Lottie.asset(
                                  getAnimationOfWeather(
                                      dayData.dayWeather, "09:00"),
                                  width: 30.spMin,
                                  animate: false),
                              Lottie.asset(
                                  getAnimationOfWeather(
                                      dayData.nightWeather, "19:00"),
                                  width: 30.spMin,
                                  animate: false),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
