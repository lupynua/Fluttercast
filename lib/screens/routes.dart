import 'package:flutter/material.dart';
import 'package:fluttercast/screens/main_screen.dart';
import 'package:fluttercast/screens/settings_screen.dart';

class Routes {
  static final main = <String, WidgetBuilder>{
    "/main": (context) => MainScreen(),
    "/settings": (context) => SettingsScreen()
  };
}
