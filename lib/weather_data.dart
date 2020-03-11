import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
class WeatherData {
  Weather weather;
  IconData iconData;

  List<Weather> forecast;

  WeatherData({this.weather,
    this.iconData,
    this.forecast});
}