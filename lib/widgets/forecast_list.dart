import 'package:flutter/material.dart';
import 'package:fluttercast/extentions/icon_helper.dart';
import 'package:fluttercast/main.dart';
import 'package:fluttercast/models/weather_model.dart';
import 'package:intl/intl.dart';

import 'forecast_item.dart';

class ForecastList extends StatelessWidget {
  const ForecastList({
    Key key,
    @required this.forecast,
  }) : super(key: key);

  final List<WeatherModel> forecast;

  @override
  Widget build(BuildContext context) {
    Color primaryDarkColor =
        AppStateContainer.of(context).theme.primaryColorDark;

    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: primaryDarkColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      height: 125,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5),
        scrollDirection: Axis.horizontal,
        itemCount: this.forecast.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = this.forecast[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Center(
                child: ForecastItem(
              DateFormat('E, HH:mm')
                  .format(DateTime.fromMillisecondsSinceEpoch(item.date)),
              item.temperature.round().toString() + "°",
              iconData: IconHelper.getIconData(item.icon),
            )),
          );
        },
      ),
    );
  }
}
