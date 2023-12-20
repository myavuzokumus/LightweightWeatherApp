import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../main.dart';
import '../../models/hourly_weather.dart';
import '../../models/weather_func.dart';
import '../../models/weather_info.dart';

class HourlyStatusCard extends StatefulWidget {
  const HourlyStatusCard({required this.weatherInfo, required this.currentTime, super.key, required this.returnedJsonData});

  final WeatherInfo weatherInfo;
  final String currentTime;
  final Map<String, dynamic> returnedJsonData;

  @override
  State<HourlyStatusCard> createState() => _HourlyStatusCardState();
}

class _HourlyStatusCardState extends State<HourlyStatusCard> {

  late final ScrollController scrollController;

  late final List<HourlyWeather> hourlyWeatherDetails;

  @override
  void initState() {
    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((final _) {
      if (scrollController.hasClients) {
        scrollController.animateTo(hours.indexOf(widget.currentTime).toDouble() * 76,
            duration: const Duration(seconds: 1), curve: Curves.easeOut);
      }
    });

    if (lastSelectedCity != "Select City" || widget.returnedJsonData.isNotEmpty) {
      hourlyWeatherDetails = getHoursData();
    }

    super.initState();

  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  List<HourlyWeather> getHoursData() {

    return widget.returnedJsonData["hourly"].map<HourlyWeather>( (final value) => widget.weatherInfo.hourlyInfo(value)).toList();

  }


  @override
  Widget build(final BuildContext context) {

    return Container(
      width: 425,
      height: 150,
      margin: EdgeInsets.only(top: 25.h, bottom: 5.h),
      child: ShaderMask(
          shaderCallback: (final rect) {
            return const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
              stops: [0.0, 0.1, 0.9, 1.0], // 10% purple, 80% transparent, 10% purple
            ).createShader(Rect.fromLTRB(0, 0, rect.width, 0));
          },
        child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: hours.length,
            itemBuilder: (final BuildContext context, final int index) {

              return Card(
                shadowColor: Colors.black,
                color: Colors.indigo.withOpacity(0.25),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                    splashColor: Colors.white.withAlpha(30),
                    onTap: () {},
                    child: Container(
                      width: 75,
                      padding: const EdgeInsets.all(3),
                      color: widget.currentTime == hours[index]
                          ? Colors.indigo.shade300
                          : Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(hours[index]),
                          Lottie.asset(getAnimationOfWeather(
                              hourlyWeatherDetails[index].weatherType, hours[index])),
                          Text("${hourlyWeatherDetails[index].temperature}°"),
                        ],
                      ),
                    )),
              );
            }),
      ),
    );
  }
}
