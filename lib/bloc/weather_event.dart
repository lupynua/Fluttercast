import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  final List properties;

  WeatherEvent(this.properties);

  @override
  List<Object> get props => properties;
}

class FetchEvent extends WeatherEvent {
  FetchEvent() : super([]);
}

class ErrorEvent extends WeatherEvent {
  ErrorEvent() : super([]);
}
