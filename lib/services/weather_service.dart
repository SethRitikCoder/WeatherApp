import 'dart:convert';

import 'package:weatherapp/models/geo_model.dart';
import 'package:weatherapp/models/weather_model.dart';

import 'package:http/http.dart' as http;

class WeatherService {
  final String apikey = "3dc6f3a69cbb41370990ddcffef1bc76";
  Future<WeatherModel?> weatherData(String cityname) async {
    try {
      if (cityname.trim().isEmpty) {
        throw Exception("Please enter a city name.");
      }

      String geourl =
          "https://api.openweathermap.org/geo/1.0/direct?q=$cityname&limit=1&appid=$apikey";

      final georesponse = await http.get(Uri.parse(geourl));
      if (georesponse.statusCode != 200) {
        throw Exception("Geo API error: ${georesponse.statusCode}");
      }

      var data = jsonDecode(georesponse.body);
      if (data is! List || data.isEmpty) {
        throw Exception("City not found.");
      }

      GeoModel geomodel = GeoModel.fromjson(data[0]);

      final lat = geomodel.lat;
      final lon = geomodel.lon;

      final String weatherUrl =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apikey&units=metric";

      final response = await http.get(Uri.parse(weatherUrl));
      if (response.statusCode != 200) {
        throw Exception("Weather API error: ${response.statusCode}");
      }

      var rawdata = jsonDecode(response.body);
      WeatherModel weatherModel = WeatherModel.fromJson(rawdata);
      return weatherModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
