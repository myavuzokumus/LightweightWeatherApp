import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

//import 'models/weather_info.dart';

class DataService {

  final targetedServer = (defaultTargetPlatform == TargetPlatform.android && defaultTargetPlatform == TargetPlatform.iOS) ? "10.0.2.2:8000" : "localhost:8000";

  Future<Map<String, dynamic>> getCityWeatherInfo(final String requestedCity) async {


    final baseURL = Uri.parse("http://$targetedServer/weatherinfodetails?city=$requestedCity");
    final response = await http.get(baseURL);

    if (response.statusCode == 200){
      final json = jsonDecode(utf8.decode(response.bodyBytes));

      final element = (json["city"] != null) ? json : null;

      //final element = json.firstWhere((final map) => (WeatherInfo.fromMap(map).city == requestedCity), orElse: () => null);

      if (element == null ){

        final params = {
          "message": "No data found for $requestedCity",
          "city": requestedCity
        };

        final postResponse = await http.post(baseURL, body: params);

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

  Future<List<String>> getSuggestion(final String suggestionWord) async {

    final baseURL = Uri.parse("http://$targetedServer/api/places");

    final String uuid = const Uuid().v4();


    final params = {
      "message": "Token sended",
      "uuid": uuid,
      "suggestionWord": suggestionWord
    };


    final postResponse = await http.post(baseURL, body: params, headers: {"Access-Control-Allow-Origin": "*"});

    if (postResponse.statusCode == 200) {

      return List.from(jsonDecode(postResponse.body)['predictions'].map((final map) => map["description"]));

    } else {
      throw Exception("Request failed with status: ${postResponse.statusCode}.");
    }
  }

  //Google Maps AutoComplete Places API moved on Django side.
/*  static Future<List<String>> getSuggestion(final String suggestionWord) async {

    final String uuid = const Uuid().v4();

    final String? placesApiKey = dotenv.env["PLACES_API_KEY"]; //For use enable flutter_dotenv in pubspec.yaml
    const String baseURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    final String request = "$baseURL?input=$suggestionWord&key=$placesApiKey&sessionToken=$uuid&types=country|administrative_area_level_1";

    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200){
        return List.from(jsonDecode(response.body)['predictions'].map((final map) => map["description"]));
    }
    else {
      throw Exception("Failed to load data.");
    }
  }*/

}
