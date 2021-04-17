import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:songlyrics/logic/city_search_bloc/city_search_bloc.dart';
import 'package:songlyrics/models/custom_exception/city_exception.dart';
import 'package:songlyrics/models/weather.dart';
import 'package:songlyrics/repositories/geolocator_repository.dart';
import 'package:songlyrics/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository;
  final CitySearchBloc citySearchBloc;

  GeolocatorRepository geolocatorRepository;
  WeatherBloc(
      {this.citySearchBloc, this.weatherRepository, this.geolocatorRepository})
      : super(WeatherInitial()) {
    cityBlocSubscription = citySearchBloc.listen((state) {
      if (state is CityLoaded) {
        add(FetchWeatherByCityTyped(cityTyped: state.cityTyped));
      }
      if (state is CitySearchError) {
        add(FetchWeatherError(state.errorMessage));
      }
    });
  }
  StreamSubscription cityBlocSubscription;
  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeatherByLocation) {
      yield* _mapFetchWeatherByLocationToState();
    }

    // if (event is FetchWeatherByCityTyped) {
    //   yield* _mapFetchedWeatherTypedCity(event);
    // }
    if (event is FetchWeatherError) {
      yield WeatherLoadError(errorMessage: event.message);
    }
    if (event is CitySearchQuery) {
      yield* _mapCitySearchQueryToState(event);
    }
  }

  Stream<WeatherState> _mapCitySearchQueryToState(
      CitySearchQuery event) async* {
    try {
      yield WeatherLoading();
      var result = await weatherRepository.fetchWeatherByCityTyped(event.query);
      yield WeatherLoaded(weather: result);
    } on SocketException catch (e) {
      yield WeatherLoadError(errorMessage: 'Check your connection');
    } on CityException catch (e) {
      yield WeatherLoadCityException(e.errorMessage);
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

  // Stream<WeatherState> _mapFetchedWeatherTypedCity(
  //     FetchWeatherByCityTyped event) async* {
  //   yield WeatherLoading();
  //   try {
  //     Weather _weather =
  //         await weatherRepository.fetchWeatherByCityTyped(event.cityTyped);
  //
  //     yield WeatherLoaded(weather: _weather);
  //   } on CityException catch (e) {
  //     yield WeatherLoadCityException(e.errorMessage);
  //   } catch (e) {
  //     yield WeatherLoadError(errorMessage: 'check your connection');
  //   }
  // }

  void dispose() {
    cityBlocSubscription.cancel();
  }
}

//TODO: Remove the citySearchBloc ..and create an event for searching the city
//TODO: no need to create new state for the event mentioned above it's already sorted out
