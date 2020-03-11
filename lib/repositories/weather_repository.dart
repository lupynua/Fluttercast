import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:weather/weather.dart';import 'package:weather_icons/weather_icons.dart';

class WeatherRepository {
  static const String _apiKey = "7df955a2d1bd25efefc21b5dab13b856";
  final WeatherStation weatherStation = new WeatherStation(_apiKey);

  Future<Weather> getCurrentWeather() async {
    return await weatherStation.currentWeather();
  }

  Future<List<Weather>> getFiveDaysForecast() async {
    return await weatherStation.fiveDayForecast();
  }

  IconData getIconData(String iconCode){
    switch(iconCode){
      case '01d': return WeatherIcons.day_sunny;
      case '01n': return WeatherIcons.night_clear;
      case '02d': return WeatherIcons.day_cloudy;
      case '02n': return WeatherIcons.night_cloudy;
      case '03d':
      case '04d':
        return WeatherIcons.day_cloudy_high;
      case '03n':
      case '04n':
        return WeatherIcons.night_cloudy_high;
      case '09d': return WeatherIcons.day_showers;
      case '09n': return WeatherIcons.night_showers;
      case '10d': return WeatherIcons.day_rain;
      case '10n': return WeatherIcons.night_rain;
      case '11d': return WeatherIcons.day_thunderstorm;
      case '11n': return WeatherIcons.night_thunderstorm;
      case '13d': return WeatherIcons.day_snow;
      case '13n': return WeatherIcons.night_snow;
      case '50d': return WeatherIcons.day_fog;
      case '50n': return WeatherIcons.night_fog;
      default: return WeatherIcons.day_sunny;
    }
  }
}