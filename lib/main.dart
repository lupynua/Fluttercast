import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercast/screens/main_screen.dart';
import 'package:fluttercast/screens/routes.dart';
import 'package:fluttercast/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  BlocSupervisor.delegate = BlocDelegate();
  runApp(AppStateContainer(child: FlutterCast()));
}

class FlutterCast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        title: 'FlutterCast',
        theme: AppStateContainer.of(context).theme,
        home: MainScreen(),
        routes: Routes.main
    );
  }
}

class AppStateContainer extends StatefulWidget {
  final Widget child;

  AppStateContainer({@required this.child});

  @override
  _AppStateContainerState createState() => _AppStateContainerState();

  static _AppStateContainerState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
        _InheritedStateContainer>())
        .state;
  }
}

class _AppStateContainerState extends State<AppStateContainer> {
  static const themeCodeKey = "theme_code_key";

  int themeCode = Themes.darkThemeCode;
  ThemeData _theme = Themes.getTheme(Themes.darkThemeCode);

  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPref) {
      setState(() {
        themeCode = sharedPref.getInt(themeCodeKey) ??
            Themes.darkThemeCode;
        this._theme = Themes.getTheme(themeCode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      state: this,
      child: widget.child,
    );
  }

  ThemeData get theme => _theme;

  updateTheme(int themeCode) {
    setState(() {
      _theme = Themes.getTheme(themeCode);
      this.themeCode = themeCode;
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(themeCodeKey, themeCode);
    });
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState state;

  const _InheritedStateContainer({
    Key key,
    @required this.state,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) => true;
}
