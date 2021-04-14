import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:songlyrics/logic/city_search_bloc/city_search_bloc.dart';
import 'package:songlyrics/models/weather.dart';
import 'package:songlyrics/repositories/cityId_repository.dart';
import 'package:songlyrics/repositories/geolocator_repository.dart';
import 'package:songlyrics/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository;
  final CitySearchBloc citySearchBloc;
  final CityIdRepository cityIdRepository;

  GeolocatorRepository geolocatorRepository;
  WeatherBloc(
      {this.cityIdRepository,
      this.citySearchBloc,
      this.weatherRepository,
      this.geolocatorRepository})
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

    if (event is FetchWeatherByCityTyped) {
      yield* _mapFetchedWeatherTypedCity(event);
    }
    if (event is FetchWeatherError) {
      yield WeatherLoadError(errorMessage: event.message);
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
      yield WeatherLoadError(errorMessage: e);
    }
  }

  Stream<WeatherState> _mapFetchedWeatherTypedCity(
      FetchWeatherByCityTyped event) async* {
    yield WeatherLoading();
    try {
      Weather _weather =
          await weatherRepository.fetchWeatherByCityTyped(event.cityTyped);

      yield WeatherLoaded(weather: _weather);
    } catch (e) {
      yield WeatherLoadError(errorMessage: e.toString());
    }
  }

  void dispose() {
    cityBlocSubscription.cancel();
  }
}
