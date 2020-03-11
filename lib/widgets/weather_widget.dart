import 'package:flutter/material.dart';
import 'package:fluttercast/main.dart';
import 'package:fluttercast/weather_data.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherData weatherData;

  WeatherWidget({this.weatherData}) : assert(weatherData != null);

  @override
  Widget build(BuildContext context) {
    Color accentColor = AppStateContainer.of(context).theme.accentColor;
    Color primaryDarkColor = AppStateContainer.of(context).theme.primaryColorDark;

    return Wrap(
      spacing: 32,
      children: <Widget>[Container(
        padding: EdgeInsets.symmetric(vertical: 32),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: primaryDarkColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: accentColor,
                size: 40,
              ),
              Text(
                this.weatherData.weather.areaName,
                style: TextStyle(color: accentColor, fontSize: 40),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(this.weatherData.weather.weatherMain,
                style: TextStyle(color: accentColor, fontSize: 24)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Icon(
                  weatherData.iconData,
                  size: 100,
                  color: accentColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  this
                          .weatherData
                          .weather
                          .temperature
                          .celsius
                          .toInt()
                          .toString() +
                      "°",
                  style: TextStyle(color: accentColor, fontSize: 100),
                ),
              )
            ]),
          )
        ]),
      ),
    ]);
  }
}
