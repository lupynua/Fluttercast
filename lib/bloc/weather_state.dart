import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttercast/models/weather_data.dart';

abstract class WeatherState extends Equatable {
  final List properties;

  WeatherState(this.properties);

  @override
  List<Object> get props => properties;
}

class EmptyState extends WeatherState {
  EmptyState() : super([]);
}

class LoadingState extends WeatherState {
  LoadingState() : super([]);
}

class LoadedState extends WeatherState {
  final WeatherData weatherData;

  LoadedState({@required this.weatherData})
      : assert(weatherData != null),
        super([weatherData]);
}
