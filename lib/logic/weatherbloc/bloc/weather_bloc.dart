import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:songlyrics/models/custom_exception/city_exception.dart';
import 'package:songlyrics/models/weather.dart';
import 'package:songlyrics/repositories/geolocator_repository.dart';
import 'package:songlyrics/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository;
  // final CitySearchBloc citySearchBloc;

  GeolocatorRepository geolocatorRepository;

  WeatherBloc({@required this.geolocatorRepository, this.weatherRepository})
      : super(WeatherInitial());

  StreamSubscription cityBlocSubscription;
  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeatherByLocation) {
      yield* _mapFetchWeatherByLocationToState();
    }

    if (event is CitySearchQuery) {
      yield* _mapCitySearchQueryToState(event);
    }
  }

  Stream<WeatherState> _mapCitySearchQueryToState(
      CitySearchQuery event) async* {
    try {
      yield CitySearched();
      yield WeatherLoading();
      var result = await weatherRepository.fetchWeatherByCityTyped(event.query);
      yield WeatherLoaded(weather: result);
    } on SocketException catch (e) {
      yield WeatherLoadError(errorMessage: 'Check your connection');
    } on CityException catch (e) {
      yield WeatherLoadCityException('${event.query} not found');
    }
  }

  Stream<WeatherState> _mapFetchWeatherByLocationToState() async* {
    try {
      yield WeatherLoading();
      LocationData _location = await geolocatorRepository.getCurrentLocation();
      Weather result = await weatherRepository.fetchWeatherByLocationRepo(
          latitude: _location.latitude, longitude: _location.longitude);
      yield WeatherLoaded(weather: result);
    } catch (e) {
      yield WeatherLoadError(errorMessage: 'check your connection');
    }
  }

  void dispose() {
    cityBlocSubscription.cancel();
  }
}
