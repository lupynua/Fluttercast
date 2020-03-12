import 'package:flutter/material.dart';
import 'package:fluttercast/main.dart';

class ForecastItem extends StatelessWidget {
  final String date;
  final String temperature;
  final IconData iconData;

  ForecastItem(this.date, this.temperature, {this.iconData});

  @override
  Widget build(BuildContext context) {
    Color accentColor = AppStateContainer.of(context).theme.accentColor;
    return Container(
      width: 82,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            this.date,
            style: TextStyle(color: accentColor),
          ),
          SizedBox(
            height: 10,
          ),
          this.iconData != null
              ? Icon(
                  iconData,
                  color: accentColor,
                  size: 25,
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
          SizedBox(
            height: 10,
          ),
          Text(
            this.temperature,
            style: TextStyle(color: accentColor, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
