import 'package:flutter/material.dart';

class Themes {
  static const darkThemeCode = 0;
  static const lightThemeCode = 1;

  static final _dark = ThemeData(
    primaryColorDark: Color(0xFF121212),
    buttonColor: Colors.orangeAccent,
    primarySwatch: MaterialColor(
      Color(0xFF212121).value,
      const <int, Color>{
        50: Colors.black12,
        100: Colors.black26,
        200: Colors.black38,
        300: Colors.black45,
        400: Colors.black54,
        500: Colors.black54,
        600: Colors.black54,
        700: Colors.black54,
        800: Colors.black54,
        900: Colors.black54,
      },
    ),
    accentColor: Color(0xFFE9E9E9),
    disabledColor: Colors.grey,
  );

  static final _light = ThemeData(
      primaryColorDark: Color(0xFFCCCCCC),
      buttonColor: Color(0xFFC4682E),
      primarySwatch: MaterialColor(
        Color(0xFFE9E9E9).value,
        const <int, Color>{
          50: Colors.white10,
          100: Colors.white12,
          200: Colors.white24,
          300: Colors.white30,
          400: Colors.white54,
          500: Colors.white70,
          600: Colors.white70,
          700: Colors.white,
          800: Colors.white,
          900: Colors.white,
        },
      ),
      accentColor: Color(0xFF212121),
      disabledColor: Colors.blueGrey);

  static ThemeData getTheme(int code) {
    if (code == darkThemeCode) {
      return _dark;
    }
    return _light;
  }
}
