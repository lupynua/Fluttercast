import 'package:flutter/material.dart';
import 'package:fluttercast/extentions/icon_helper.dart';
import 'package:fluttercast/main.dart';
import 'package:fluttercast/models/weather_data.dart';
import 'package:fluttercast/widgets/forecast_list.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherData weatherData;

  WeatherWidget({this.weatherData}) : assert(weatherData != null);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return _buildPortraitUI(context);
    } else {
      return _buildLandscapeUI(context);
    }
  }

  Container _buildCurrentWeatherCard({BuildContext context}) {
    final orientation = MediaQuery.of(context).orientation;
    final iconSize = orientation == Orientation.portrait ? 100.0 : 50.0;
    final textSize = orientation == Orientation.portrait ? 100.0 : 56.0;

    Color accentColor = AppStateContainer.of(context).theme.accentColor;
    Color primaryDarkColor =
        AppStateContainer.of(context).theme.primaryColorDark;

    String tempCurrent =
        weatherData.weather.temperature.round().toString() + "°";

    return Container(
      constraints: BoxConstraints.expand(width: 400, height: 360),
      padding: EdgeInsets.symmetric(vertical: 32),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                  text: this.weatherData.weather.weather,
                  size: 24,
                  color: accentColor),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: _buildIcon(
                    icon: IconHelper.getIconData(weatherData.weather.icon),
                    color: accentColor,
                    size: iconSize),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: _buildText(
                        text: tempCurrent, color: accentColor, size: textSize),
                  ),
                ],
              )
            ]),
          ]),
    );
  }

  Row _buildLocationText({Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildIcon(icon: Icons.location_on, color: color, size: 40),
        _buildText(text: weatherData.weather.location, size: 40, color: color),
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

  Container _buildAdditionalInfoCard(BuildContext context) {
    Color accentColor = AppStateContainer.of(context).theme.accentColor;
    Color primaryDarkColor =
        AppStateContainer.of(context).theme.primaryColorDark;

    String humidity = weatherData.weather.humidity.toString() + "%";
    String windSpeed = weatherData.weather.windSpeed.toString() + "m/s";
    String sunrise = DateFormat("HH:mm").format(
        DateTime.fromMillisecondsSinceEpoch(weatherData.weather.sunrise));
    String sunset = DateFormat("HH:mm").format(
        DateTime.fromMillisecondsSinceEpoch(weatherData.weather.sunset));

    return Container(
      width: 400,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primaryDarkColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildWeatherConditionColumn(
                  label: "HUMIDITY",
                  data: humidity,
                  color: accentColor,
                  size: 18),
              _buildWeatherConditionColumn(
                  label: "SUNRISE",
                  data: sunrise,
                  color: accentColor,
                  size: 18),
            ],
          ),
          Column(
            children: <Widget>[
              _buildWeatherConditionColumn(
                  label: "WIND", data: windSpeed, color: accentColor, size: 18),
              _buildWeatherConditionColumn(
                  label: "SUNSET", data: sunset, color: accentColor, size: 18)
            ],
          ),
        ],
      ),
    );
  }

  Container _buildWeatherConditionColumn(
      {String label, String data, double size, Color color}) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildText(text: label, size: size, color: color),
          _buildText(text: data, size: size, color: color),
        ],
      ),
    );
  }

  Container _buildPortraitUI(BuildContext context) {
    var lastSync = DateFormat.yMMMMd().add_jms().format(
        DateTime.fromMillisecondsSinceEpoch(weatherData.weather.syncDate));
    return Container(
      child: Column(
        children: <Widget>[
          _buildCurrentWeatherCard(context: context),
          ForecastList(
            forecast: weatherData.forecast,
          ),
          _buildAdditionalInfoCard(context),
          _buildText(
              text: "Last sync: $lastSync",
              size: 14,
              color: AppStateContainer.of(context).theme.buttonColor),
        ],
      ),
    );
  }

  Container _buildLandscapeUI(BuildContext context) {
    var lastSync = DateFormat.yMMMMd().add_jms().format(
        DateTime.fromMillisecondsSinceEpoch(weatherData.weather.syncDate));

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildCurrentWeatherCard(context: context),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ForecastList(
                  forecast: weatherData.forecast,
                ),
                _buildAdditionalInfoCard(context),
                _buildText(
                    text: "Last sync: $lastSync",
                    size: 14,
                    color: AppStateContainer.of(context).theme.buttonColor),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
