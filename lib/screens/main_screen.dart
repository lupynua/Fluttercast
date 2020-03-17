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
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _fetchWeather().catchError((error) {
      _weatherBloc.add(ErrorEvent());
    });
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
            ), label: Text("Settings", style: TextStyle(color: accentColor, fontSize: 16),),
          ),
        ],
      ),
      backgroundColor: primaryColor,
      body: Material(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(color: primaryColor),
          child: FadeTransition(
            opacity: _animation,
            child: BlocBuilder(
                bloc: _weatherBloc,
                builder: (_, WeatherState state) {
                  print("$state");
                  if (state is LoadedState) {
                    _animationController.reset();
                    _animationController.forward();
                    return RefreshIndicator(
                      color: primaryDarkColor,
                      backgroundColor: buttonColor,
                      onRefresh: _refreshWeather,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: WeatherWidget(
                          weatherData: state.weatherData,
                        ),
                      ),
                    );
                  } else if (state is LoadingState) {
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
                    _animationController.reset();
                    _animationController.forward();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.error,
                          color: buttonColor,
                          size: 75,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Can`t fetch current location.\n Please check your Internet connection or location permission",
                          style: TextStyle(color: buttonColor, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  }
                }),
          ),
        ),
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
