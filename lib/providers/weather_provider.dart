import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/weather_model.dart';
import 'package:flutter_application_1/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  bool _isLoading = false;
  WeatherModel? _weatherdata;
  String _errormessage = "";

  //getters
  WeatherModel? get weatherdata => _weatherdata;
  bool get isLoading => _isLoading;
  String get errormessage => _errormessage;

  //main function jo ui se call hoga
  Future<void> fetchData(String cityname) async {
    _isLoading = true;
    _errormessage = "";
    _weatherdata = null;
    notifyListeners();
    try {
      final data = await _weatherService.weatherData(cityname);
      _weatherdata = data;
      
    } catch (e) {
      _errormessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
