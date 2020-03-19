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
    var accentColor = AppStateContainer.of(context).theme.accentColor;
    var buttonColor = AppStateContainer.of(context).theme.buttonColor;
    var primaryDarkColor = AppStateContainer.of(context).theme.primaryColorDark;

    var tempCurrent = weatherData.weather.temperature.round().toString() + "°";

    return Container(
      constraints: BoxConstraints.tightFor(width: 400, height: 324),
      padding: EdgeInsets.symmetric(vertical: 32),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primaryDarkColor,
        border: Border.all(color: buttonColor.withOpacity(0.3), width: 2),
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
                    size: 100),
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
                        text: tempCurrent, color: accentColor, size: 100),
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
    var accentColor = AppStateContainer.of(context).theme.accentColor;
    var buttonColor = AppStateContainer.of(context).theme.buttonColor;
    var primaryDarkColor = AppStateContainer.of(context).theme.primaryColorDark;

    var humidity = weatherData.weather.humidity.toString() + "%";
    var windSpeed = weatherData.weather.windSpeed.toString() + "m/s";
    var sunrise = DateFormat("HH:mm").format(
        DateTime.fromMillisecondsSinceEpoch(weatherData.weather.sunrise));
    var sunset = DateFormat("HH:mm").format(
        DateTime.fromMillisecondsSinceEpoch(weatherData.weather.sunset));

    return Container(
      constraints: BoxConstraints.tightFor(width: 400),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primaryDarkColor,
        border: Border.all(color: buttonColor.withOpacity(0.3), width: 2),
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
    var lastSync = DateFormat.yMMMMd().add_Hms().format(
        DateTime.fromMillisecondsSinceEpoch(weatherData.weather.syncDate));
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
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
    var lastSync = DateFormat.yMMMMd().add_Hms().format(
        DateTime.fromMillisecondsSinceEpoch(weatherData.weather.syncDate));

    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildCurrentWeatherCard(context: context),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ForecastList(
                    forecast: weatherData.forecast,
                  ),
                  _buildAdditionalInfoCard(context),
                ],
              ),
            ],
          ),
          _buildText(
              text: "Last sync: $lastSync",
              size: 14,
              color: AppStateContainer.of(context).theme.buttonColor),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
