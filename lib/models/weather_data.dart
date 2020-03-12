import 'package:fluttercast/models/weather_model.dart';

class WeatherData {
  WeatherModel weather;
  List<WeatherModel> forecast;

  WeatherData({this.weather, this.forecast});
}
