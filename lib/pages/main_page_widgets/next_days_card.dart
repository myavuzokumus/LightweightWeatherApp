import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../../models/daily_weather.dart';
import '../../models/weather_func.dart';
import '../../models/weather_info.dart';
import '../main_page.dart';

class NextDaysCard extends StatelessWidget {
   NextDaysCard({required this.weatherInfo, super.key, required this.returnedJsonData});

  final WeatherInfo weatherInfo;
  final Map<String, dynamic> returnedJsonData;

  List<DailyWeather>? dayDetails;
  List<String>? nextDay;
  DailyWeather? yesterday;

  List<DailyWeather> getDailyData() {
    return returnedJsonData["daily"].map<DailyWeather>( (final value) => weatherInfo.dailyInfo(value)).toList();
  }

  @override
  Widget build(final BuildContext context) {

    if (lastSelectedCity != "Select City" && returnedJsonData.isNotEmpty) {
      dayDetails = getDailyData();
      nextDay = nextDays(nextDay: 6, currentDay: dayDetails![1].day);
      yesterday = dayDetails![0];
    }

    return Center(
      child: Card(
        shadowColor: Colors.black,
        color: Colors.indigo.withOpacity(0.25),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          //Drawer will be opening if no city added yet
          onTap: lastSelectedCity == "Select City" ? () {drawerKey.currentState!.openDrawer();} : null,
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
                      Text("${yesterday?.humidity}",
                          style: TextStyle(fontSize: 16.spMin)),
                      Lottie.asset("assets/icons/lottie/humidity.json",
                          width: 35.spMin, animate: false),
                      SizedBox(width: 6.w),
                      SizedBox(
                        width: 75.spMin,
                        child: Text(
                            "${yesterday?.dayTemperature}° / ${yesterday?.nightTemperature}°",
                            style: TextStyle(fontSize: 16.spMin)),
                      ),
                      SizedBox(width: 5.w),
                      Lottie.asset(
                          getAnimationOfWeather(yesterday?.dayWeather ?? "Sunny", "09:00"),
                          width: 30.spMin,
                          animate: false),
                      Lottie.asset(
                          getAnimationOfWeather(yesterday?.nightWeather ?? "Sunny", "19:00"),
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

                        final DailyWeather? dayData = dayDetails?[index + 2];

                        return InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Redirecting to site about that day's weather information...")));
                            final Uri url =
                            Uri.parse('https://www.visualcrossing.com/weather-forecast/$lastSelectedCity/metric');
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Text(nextDay?[index] ?? "Null",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.spMin))),
                              Text("${dayData?.humidity}",
                                  style: TextStyle(fontSize: 16.spMin)),
                              Lottie.asset("assets/icons/lottie/humidity.json",
                                  width: 35.spMin, animate: false),
                              SizedBox(width: 5.w),
                              SizedBox(
                                width: 75.spMin,
                                child: Text(
                                    "${dayData?.dayTemperature}° / ${dayData?.nightTemperature}°",
                                    style: TextStyle(fontSize: 16.spMin)),
                              ),
                              SizedBox(width: 5.w),
                              Lottie.asset(
                                  getAnimationOfWeather(
                                      dayData?.dayWeather ?? "Sunny", "09:00"),
                                  width: 30.spMin,
                                  animate: false),
                              Lottie.asset(
                                  getAnimationOfWeather(
                                      dayData?.nightWeather ?? "Sunny", "19:00"),
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
