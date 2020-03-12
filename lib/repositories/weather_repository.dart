import 'dart:async';
import 'package:fluttercast/models/weather_model.dart';
import 'package:fluttercast/repositories/local_repository.dart';
import 'package:weather/weather.dart';

class WeatherRepository {
  static const String _apiKey = "7df955a2d1bd25efefc21b5dab13b856";
  final WeatherStation weatherStation = new WeatherStation(_apiKey);

  Future<WeatherModel> getCurrentWeather() async {
    try {
      var weather = await weatherStation.currentWeather();
      print(weather);
      if (weather == null) {
        return await SQLiteDbProvider.db.getWeather();
      }
      var weatherModel = WeatherModel.fromWeather(weather, 0);

      SQLiteDbProvider.db
          .insert(weatherModel, SQLiteDbProvider.currentWeatherTable);

      return weatherModel;
    } catch (exception) {
      return Future.error(exception);
    }
  }

  Future<List<WeatherModel>> getFiveDaysForecast() async {
    try {
      var forecast = await weatherStation.fiveDayForecast();

      if (forecast == null || forecast.isEmpty) {
        return await SQLiteDbProvider.db.getForecast();
      }

      var forecastModel = forecast.map((item) {
        return WeatherModel.fromWeather(item, forecast.indexOf(item));
      }).toList();

      forecastModel.forEach((item) {
        SQLiteDbProvider.db.insert(item, SQLiteDbProvider.futureWeatherTable);
      });

      return forecastModel;
    } catch (exception) {
      return Future.error(exception);
    }
  }
}
