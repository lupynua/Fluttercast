import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercast/bloc/weather_bloc.dart';
import 'package:fluttercast/bloc/weather_event.dart';
import 'package:fluttercast/bloc/weather_state.dart';
import 'package:fluttercast/main.dart';
import 'package:fluttercast/repositories/weather_repository.dart';
import 'package:fluttercast/widgets/weather_widget.dart';
import 'package:permission_handler/permission_handler.dart';

enum OptionItems { Settings }

class MainScreen extends StatefulWidget {
  final WeatherRepository weatherRepository = WeatherRepository();

  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  WeatherBloc _weatherBloc;
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    _fetchWeather().catchError((error) {
      _weatherBloc.add(ErrorEvent());
    });
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = AppStateContainer.of(context).theme.primaryColor;
    Color primaryDarkColor =
        AppStateContainer.of(context).theme.primaryColorDark;
    Color accentColor = AppStateContainer.of(context).theme.accentColor;
    Color buttonColor = AppStateContainer.of(context).theme.buttonColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryDarkColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Fluttercast",
              style: TextStyle(color: buttonColor, fontSize: 24),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed("/settings");
              },
              icon: Icon(
                Icons.settings,
                color: accentColor,
              ),
              label: Text(
                "Settings",
                style: TextStyle(color: accentColor),
              ))
        ],
      ),
      backgroundColor: primaryColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return RefreshIndicator(
            onRefresh: _refreshWeather,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: FadeTransition(
                  opacity: _animation,
                  child: BlocBuilder(
                    bloc: _weatherBloc,
                    builder: (_, WeatherState state) {
                      if (state is LoadedState) {
                        _animationController.reset();
                        _animationController.forward();
                        return WeatherWidget(weatherData: state.weatherData);
                      } else if (state is LoadingState) {
                        print("LOADING");
                        _animationController.reset();
                        _animationController.forward();
                        return Center(
                          child: SizedBox(
                            width: 75,
                            height: 75,
                            child: CircularProgressIndicator(
                              backgroundColor: buttonColor,
                            ),
                          ),
                        );
                      } else {
                        print("ERROR");
                        _animationController.reset();
                        _animationController.forward();
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: buttonColor,
                              size: 75,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Can`t fetch current location.\n Please check permission in system settings",
                              style:
                                  TextStyle(color: buttonColor, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _fetchWeather() async {
    var permissionHandler = PermissionHandler();
    var permissionResult = await permissionHandler
        .requestPermissions([PermissionGroup.locationWhenInUse]);

    switch (permissionResult[PermissionGroup.locationWhenInUse]) {
      case PermissionStatus.denied:
      case PermissionStatus.unknown:
        print('location permission denied');
        throw Error();
    }
    _weatherBloc.add(FetchEvent());
  }

  Future<void> _refreshWeather() async {
    _fetchWeather();
  }
}
