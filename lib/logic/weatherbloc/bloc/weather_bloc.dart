import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:songlyrics/logic/city_search_bloc/city_search_bloc.dart';
import 'package:songlyrics/models/city_id.dart';
import 'package:songlyrics/models/weather.dart';
import 'package:songlyrics/repositories/cityId_repository.dart';
import 'package:songlyrics/repositories/geolocator_repository.dart';
import 'package:songlyrics/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  final CitySearchBloc citySearchBloc;

  GeolocatorRepository geolocatorRepository;
  WeatherBloc(
      {this.citySearchBloc, this.weatherRepository, this.geolocatorRepository})
      : super(WeatherInitial()) {
    cityBloc = citySearchBloc.listen((state) {
      if (state is CityPicked) {
        add(FetchWeatherByCityId(cityId: state.selectedCity));
      }
    });
  }
  StreamSubscription cityBloc;
  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeatherByLocation) {
      yield WeatherLoading();
      yield* _mapFetchWeatherByLocationToState();
    }
    if (event is FetchWeatherByCityId) {
      yield WeatherLoading();
      yield* _mapFetchedWeatherTypedCity(event);
    }
  }

  Stream<WeatherState> _mapFetchWeatherByLocationToState() async* {
    yield WeatherLoading();

    try {
      var _location = await geolocatorRepository.getCurrentLocation();

      Weather weather =
          await weatherRepository.fetchWeatherByLocation(_location);
      yield WeatherLoaded(weather: weather);
    } catch (e) {
      yield WeatherLoadError(errorMessage: e.toString());
    }
  }

  Stream<WeatherState> _mapFetchedWeatherTypedCity(
      FetchWeatherByCityId event) async* {
    try {
      Weather _weather = await weatherRepository.fetchWeatherByCityId(event.cityId);

      yield WeatherLoaded(weather:_weather);
    } catch (e) {
      yield WeatherLoadError(errorMessage: e.toString());
    }
  }

  void dispose() {
    cityBloc.cancel();
  }
}
