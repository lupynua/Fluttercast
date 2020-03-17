import 'package:weather/weather.dart';

class WeatherModel {
  final String icon, location, weather;
  final double temperature, humidity, windSpeed;
  final int id, sunrise, sunset, date, syncDate;

  static final columns = [
    "id",
    "icon",
    "location",
    "weather",
    "temperature",
    "humidity",
    "wind_speed",
    "sunrise",
    "sunset",
    "date",
    "sync_date"
  ];

  WeatherModel(
      {this.id,
      this.icon,
      this.location,
      this.weather,
      this.temperature,
      this.humidity,
      this.windSpeed,
      this.sunrise,
      this.sunset,
      this.date,
      this.syncDate});

  factory WeatherModel.fromWeather(Weather weather, int id) {
    return WeatherModel(
        id: id,
        icon: weather.weatherIcon,
        location: weather.areaName,
        weather: weather.weatherMain,
        temperature: weather.temperature.celsius,
        humidity: weather.humidity,
        windSpeed: weather.windSpeed,
        sunrise: weather.sunrise == null
            ? 0
            : weather.sunrise.millisecondsSinceEpoch,
        sunset:
            weather.sunset == null ? 0 : weather.sunset.millisecondsSinceEpoch,
        date: weather.date.millisecondsSinceEpoch,
        syncDate: DateTime.now().millisecondsSinceEpoch);
  }

  factory WeatherModel.fromMap(Map<String, dynamic> data) {
    return WeatherModel(
        id: data['id'],
        icon: data['icon'],
        location: data['location'],
        weather: data['weather'],
        temperature: data['temperature'],
        humidity: data['temp_min'],
        windSpeed: data['temp_max'],
        sunrise: data['sunrise'],
        sunset: data['sunset'],
        date: data['date'],
        syncDate: data['sync_date']);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "icon": icon,
        "location": location,
        "weather": weather,
        "temperature": temperature,
        "humidity": humidity,
        "wind_speed": windSpeed,
        "sunrise": sunrise,
        "sunset": sunset,
        "date": date,
        "sync_date": syncDate,
      };
}
