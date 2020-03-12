import 'dart:async';
import 'package:weather/weather.dart';

class WeatherRepository {
  static const String _apiKey = "7df955a2d1bd25efefc21b5dab13b856";
  final WeatherStation weatherStation = new WeatherStation(_apiKey);

  Future<Weather> getCurrentWeather() async {
    return await weatherStation.currentWeather();
  }

  Future<List<Weather>> getFiveDaysForecast() async {
    return await weatherStation.fiveDayForecast();
  }
}
