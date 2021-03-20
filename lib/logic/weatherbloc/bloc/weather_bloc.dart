import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:songlyrics/repositories/geolocator_repository.dart';

import '../../../models/weather.dart';
import '../../../repositories/weather_repositories.dart';
import '../../geolocationbloc/bloc/geolocation_bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  GeolocatorRepository geolocatorRepository;
  WeatherBloc({this.weatherRepository, this.geolocatorRepository})
      : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeatherByLocation) {
      yield WeatherLoading();
      yield* _mapFetchWeatherByLocationtOState();
    }
    if (event is FetchedWeatherTypedCity) {
      yield WeatherLoading();
      yield* _mapFetchedWeatherTypedCity(event);
    }
  }

  Stream<WeatherState> _mapFetchWeatherByLocationtOState() async* {
    yield WeatherLoading();

    try {
      var _locationResult = await geolocatorRepository.getCurrentLocation();

      Weather weather =
          await weatherRepository.fetchWeatherByLocation(_locationResult);
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
}
