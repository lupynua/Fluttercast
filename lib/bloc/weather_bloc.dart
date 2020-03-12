import 'package:fluttercast/models/weather_data.dart';
import 'package:fluttercast/models/weather_model.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercast/bloc/weather_event.dart';
import 'package:fluttercast/bloc/weather_state.dart';
import 'package:fluttercast/repositories/weather_repository.dart';

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
        final currentWeather = await weatherRepository.getCurrentWeather();

        final List<WeatherModel> forecast =
            await weatherRepository.getFiveDaysForecast();
        final WeatherData weatherData =
            WeatherData(weather: currentWeather, forecast: forecast);

        yield LoadedState(weatherData: weatherData);
      } catch (exception) {
        print(exception);
        yield EmptyState();
      }
    } else {
      yield EmptyState();
    }
  }
}
