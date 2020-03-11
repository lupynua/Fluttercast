import 'package:fluttercast/weather_data.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercast/bloc/weather_event.dart';
import 'package:fluttercast/bloc/weather_state.dart';
import 'package:fluttercast/repositories/weather_repository.dart';
import 'package:weather/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState {
    return EmptyState();
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchEvent) {
      yield LoadingState();
      try {
        final Weather currentWeather =
            await weatherRepository.getCurrentWeather();

        final List<Weather> forecast =
            await weatherRepository.getFiveDaysForecast();

        final WeatherData weatherData = WeatherData(
            weather: currentWeather,
            iconData: weatherRepository.getIconData(currentWeather.weatherIcon),
            forecast: forecast);

        yield LoadedState(weatherData: weatherData);
      } catch (exception) {
        print("WTF" + exception);
        yield ErrorState(error: exception);
      }
    } else {
      yield ErrorState(error: "Error");
    }
  }
}
