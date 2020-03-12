import 'package:flutter/material.dart';
import 'package:fluttercast/main.dart';
import 'package:fluttercast/weather_data.dart';
import 'package:fluttercast/widgets/forecast_list.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherData weatherData;

  WeatherWidget({this.weatherData}) : assert(weatherData != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildCurrentWeatherCard(context: context),
          ForecastList(
            forecast: weatherData.forecast,
          ),
        ],
      ),
    );
  }

  Wrap _buildCurrentWeatherCard({BuildContext context}) {
    Color accentColor = AppStateContainer.of(context).theme.accentColor;
    Color primaryDarkColor =
        AppStateContainer.of(context).theme.primaryColorDark;

    String tempMin =
        weatherData.weather.tempMin.celsius.round().toString() + "°";
    String tempMax =
        weatherData.weather.tempMax.celsius.round().toString() + "°";
    String tempCurrent =
        weatherData.weather.temperature.celsius.round().toString() + "°";
    String sunrise =
        DateFormat("HH:mm").format(weatherData.weather.sunrise.toLocal());
    String sunset =
        DateFormat("HH:mm").format(weatherData.weather.sunset.toLocal());

    return Wrap(spacing: 32, children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(vertical: 32),
        margin: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: primaryDarkColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLocationText(color: accentColor),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildText(
                    text: this.weatherData.weather.weatherMain,
                    size: 24,
                    color: accentColor),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _buildIcon(
                            icon: weatherData.iconData,
                            color: accentColor,
                            size: 100),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _buildText(
                            text: tempCurrent, color: accentColor, size: 100),
                      )
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildWeatherConditionColumn(
                      label: "MIN",
                      data: tempMin,
                      color: accentColor,
                      size: 24),
                  SizedBox(
                    width: 20,
                  ),
                  _buildWeatherConditionColumn(
                      label: "MAX",
                      data: tempMax,
                      color: accentColor,
                      size: 24),
                  SizedBox(
                    width: 40,
                  ),
                  _buildWeatherConditionColumn(
                      label: "SUNRISE",
                      data: sunrise,
                      color: accentColor,
                      size: 24),
                  SizedBox(
                    width: 20,
                  ),
                  _buildWeatherConditionColumn(
                      label: "SUNSET",
                      data: sunset,
                      color: accentColor,
                      size: 24),
                ],
              )
            ]),
      ),
    ]);
  }

  Row _buildLocationText({Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildIcon(icon: Icons.location_on, color: color, size: 40),
        _buildText(text: weatherData.weather.areaName, size: 40, color: color),
      ],
    );
  }

  Text _buildText({String text, double size, Color color}) {
    return Text(text, style: TextStyle(color: color, fontSize: size));
  }

  Icon _buildIcon({IconData icon, double size, Color color}) {
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }

  Column _buildWeatherConditionColumn(
      {String label, String data, double size, Color color}) {
    return Column(
      children: <Widget>[
        _buildText(text: label, size: size, color: color),
        _buildText(text: data, size: size, color: color),
      ],
    );
  }
}
