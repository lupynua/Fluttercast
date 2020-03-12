import 'package:weather/weather.dart';

class WeatherModel {
  final int id;
  final String icon;
  final String location;
  final String weather;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final int sunrise;
  final int sunset;
  final int date;

  static final columns = [
    "id",
    "icon",
    "location",
    "weather",
    "temperature",
    "temp_min",
    "temp_max",
    "sunrise",
    "sunset",
    "date"
  ];

  WeatherModel(
      {this.id,
      this.icon,
      this.location,
      this.weather,
      this.temperature,
      this.tempMin,
      this.tempMax,
      this.sunrise,
      this.sunset,
      this.date});

  factory WeatherModel.fromWeather(Weather weather, int id) {
    return WeatherModel(
      id: id,
      icon: weather.weatherIcon,
      location: weather.areaName,
      weather: weather.weatherMain,
      temperature: weather.temperature.celsius,
      tempMin: weather.tempMin.celsius,
      tempMax: weather.tempMax.celsius,
      sunrise: weather.sunrise.millisecondsSinceEpoch,
      sunset: weather.sunset.millisecondsSinceEpoch,
      date: weather.date.millisecondsSinceEpoch,
    );
  }

  factory WeatherModel.fromMap(Map<String, dynamic> data) {
    return WeatherModel(
      id: data['id'],
      icon: data['icon'],
      location: data['location'],
      weather: data['weather'],
      temperature: data['temperature'],
      tempMin: data['temp_min'],
      tempMax: data['temp_max'],
      sunrise: data['sunrise'],
      sunset: data['sunset'],
      date: data['date'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "icon": icon,
        "location": location,
        "weather": weather,
        "temperature": temperature,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "sunrise": sunrise,
        "sunset": sunset,
        "date": date,
      };
}
