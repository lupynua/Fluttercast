import 'package:flutter/material.dart';
import 'package:fluttercast/main.dart';
import 'package:fluttercast/themes.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = AppStateContainer.of(context).theme.primaryColor;
    Color accentColor = AppStateContainer.of(context).theme.accentColor;
    Color buttonColor = AppStateContainer.of(context).theme.buttonColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: primaryColor,
        child: ListView(
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withOpacity(0.1),
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Dark",
                    style: TextStyle(
                        color: AppStateContainer.of(context).theme.accentColor),
                  ),
                  Radio(
                    value: Themes.darkThemeCode,
                    groupValue: AppStateContainer.of(context).themeCode,
                    onChanged: (value) {
                      AppStateContainer.of(context).updateTheme(value);
                    },
                    activeColor: buttonColor,
                  )
                ],
              ),
            ),
            Divider(
              color: primaryColor,
              height: 2,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withOpacity(0.1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Light",
                    style: TextStyle(color: accentColor),
                  ),
                  Radio(
                    value: Themes.lightThemeCode,
                    groupValue: AppStateContainer.of(context).themeCode,
                    onChanged: (value) {
                      AppStateContainer.of(context).updateTheme(value);
                    },
                    activeColor: buttonColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
