import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'models/weather_info.dart';

mixin DataService {

  static Future<Map<String, dynamic>> getCityWeatherInfo(final String requestedCity) async {

    final baseURL = (defaultTargetPlatform == TargetPlatform.android && defaultTargetPlatform == TargetPlatform.iOS) ? Uri.parse("http://10.0.2.2:8000/weatherinfodetails") : Uri.parse("http://localhost:8000/weatherinfodetails");

    final response = await http.get(baseURL);

    if (response.statusCode == 200){
      final List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
      final element = json.firstWhere((final map) => (WeatherInfo.fromMap(map).city == requestedCity), orElse: () => null);

      if (element == null ){

        final postUrl = baseURL;

        final params = {
          "message": "No data found for $requestedCity",
          "city": requestedCity
        };

        final postResponse = await http.post(postUrl, body: params);

        if (postResponse.statusCode == 200) {
          final postData = jsonDecode(postResponse.body);

          return postData;

        } else {
          throw Exception("Request failed with status: ${postResponse.statusCode}.");
        }
      }
      else {
        return element;
      }
    }
    else {
      throw Exception("Failed to load data.");
    }
  }

  static Future<List<String>> getSuggestion(final String suggestionWord) async {

    final String uuid = const Uuid().v4();

    final String? placesApiKey = dotenv.env["PLACES_API_KEY"];
    const String baseURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    final String request = "$baseURL?input=$suggestionWord&key=$placesApiKey&sessionToken=$uuid&types=country|administrative_area_level_1";

    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200){
        return List.from(jsonDecode(response.body)['predictions'].map((final map) => map["description"]));
    }
    else {
      throw Exception("Failed to load data.");
    }
  }

}
