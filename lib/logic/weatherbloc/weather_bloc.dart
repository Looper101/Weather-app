import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import '../../error/exception/city_exception.dart';
import '../../models/weather.dart';
import '../../repositories/weather_repository.dart';

import 'barrel.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({
    this.location,
    this.weatherRepository,
  }) : super(WeatherInitial());

  final Location location;

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

    if (event is LocationChanged) {
      yield* _mapLocationChangedToState(event);
    }
  }

  Stream<WeatherState> _mapCitySearchQueryToState(
      CitySearchQuery event) async* {
    try {
      yield CitySearched();
      yield WeatherLoading();
      var result = await weatherRepository.fetchWeatherByCityTyped(event.query);
      yield WeatherLoaded(weather: result);
      // ignore: unused_catch_clause
    } on SocketException catch (e) {
      yield WeatherLoadError(errorMessage: 'Check your connection');
      // ignore: unused_catch_clause
    } on CityException catch (e) {
      yield WeatherLoadCityException('${event.query} not found');
    }
  }

  Stream<WeatherState> _mapFetchWeatherByLocationToState() async* {
    try {
      yield WeatherLoading();
      LocationData _location = await location.getLocation();

      Weather result = await _fetchWeather(_location);

      yield WeatherLoaded(weather: result);
    } catch (e) {
      yield WeatherLoadError();
    }
  }

  Future<Weather> _fetchWeather(LocationData _location) async {
    return await weatherRepository.fetchWeatherByLocationRepo(
        latitude: _location.latitude, longitude: _location.longitude);
  }

  _mapLocationChangedToState(LocationChanged event) async* {
    try {
      Weather weatherResult = await _fetchWeather(event.location);
      yield WeatherLoaded(weather: weatherResult);
    } catch (e) {
      var oldStateWeather = (state as WeatherLoaded).weather;

      yield WeatherLoaded(weather: oldStateWeather);
    }
  }
}
