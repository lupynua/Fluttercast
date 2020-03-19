import 'package:flutter/material.dart';
import 'package:fluttercast/main.dart';
import 'package:fluttercast/themes.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var primaryColor = AppStateContainer.of(context).theme.primaryColor;
    var primaryDarkColor = AppStateContainer.of(context).theme.primaryColorDark;
    var accentColor = AppStateContainer.of(context).theme.accentColor;
    var buttonColor = AppStateContainer.of(context).theme.buttonColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryDarkColor,
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Theme",
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            _buildSettingsEntry(
                label: "Dark",
                radioValue: Themes.darkThemeCode,
                groupValue: AppStateContainer.of(context).themeCode,
                onChanged: (value) =>
                    AppStateContainer.of(context).updateTheme(value),
                color: primaryDarkColor,
                accentColor: accentColor,
                activeColor: buttonColor),
            Divider(
              color: primaryColor,
              height: 4,
            ),
            _buildSettingsEntry(
                label: "Light",
                radioValue: Themes.lightThemeCode,
                groupValue: AppStateContainer.of(context).themeCode,
                onChanged: (value) =>
                    AppStateContainer.of(context).updateTheme(value),
                color: primaryDarkColor,
                accentColor: accentColor,
                activeColor: buttonColor),
          ],
        ),
      ),
    );
  }

  Container _buildSettingsEntry(
      {String label,
      int radioValue,
      int groupValue,
      Function onChanged,
      Color color,
      Color accentColor,
      Color activeColor}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: activeColor.withOpacity(0.3), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: color,
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(color: accentColor),
          ),
          Radio(
            value: radioValue,
            groupValue: groupValue,
            onChanged: (value) {
              onChanged(value);
            },
            activeColor: activeColor,
          ),
        ],
      ),
    );
  }
}
