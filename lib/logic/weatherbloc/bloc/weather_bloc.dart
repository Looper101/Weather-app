import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

import '../../../models/weather.dart';
import '../../../repositories/weather_repositories.dart';
import '../../geolocationbloc/bloc/geolocation_bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  final GeolocationBloc geolocationBloc;

  StreamSubscription _streamSubscription;
  WeatherBloc({this.weatherRepository, this.geolocationBloc})
      : super(WeatherInitial()) {
    _streamSubscription = geolocationBloc.listen((state) {
      if (state is GeolocationLoaded) {
        add(FetchWeatherByLocation(location: state.position));
      }
    });
  }

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeatherByLocation) {
      yield WeatherLoading();
      yield* _mapFetchWeatherByLocationtOState(event);
    }
    if (event is FetchedWeatherTypedCity) {
      yield WeatherLoading();
      yield* _mapFetchedWeatherTypedCity(event);
    }
  }

  Stream<WeatherState> _mapFetchWeatherByLocationtOState(
      FetchWeatherByLocation event) async* {
    yield WeatherLoading();
    _streamSubscription?.cancel();

    try {
      Weather weather =
          await weatherRepository.fetchWeatherByLocation(event.location);
      yield WeatherLoaded(weather: weather);
    } catch (e) {
      yield WeatherLoadError(errorMessage: e.toString());
    }
  }

  Stream<WeatherState> _mapFetchedWeatherTypedCity(
      FetchedWeatherTypedCity event) async* {
    try {
      var exisingState = await weatherRepository.getWeatherData(event.query);

      yield WeatherLoaded(weather: exisingState);
    } catch (e) {
      yield WeatherLoadError(errorMessage: e.toString());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
