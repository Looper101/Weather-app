import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:songlyrics/logic/city_search_bloc/city_search_bloc.dart';
import 'package:songlyrics/models/city_id.dart';
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
      if (state is CityPicked) {
        add(FetchWeatherByCityId(cityId: state.selectedCity));
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
    if (event is FetchWeatherByCityId) {
      yield* _mapFetchedWeatherTypedCity(event);
    }
  }

  Stream<WeatherState> _mapFetchWeatherByLocationToState() async* {
    try {
      yield WeatherLoading();
      LocationData _location = await geolocatorRepository.getCurrentLocation();
      // print('The weather location is ${_location.latitude}');
      City cityResult = await cityIdRepository.fetchCityIdByLocation(_location);

      var newCityId = cityResult.cities.first;
      Weather result = await weatherRepository.fetchWeatherByCityId(newCityId);

      print(result);
      yield WeatherLoaded(weather: result);
    } catch (e) {
      yield WeatherLoadError(errorMessage: e);
    }
  }

  Stream<WeatherState> _mapFetchedWeatherTypedCity(
      FetchWeatherByCityId event) async* {
    yield WeatherLoading();
    try {
      Weather _weather =
          await weatherRepository.fetchWeatherByCityId(event.cityId);

      yield WeatherLoaded(weather: _weather);
    } catch (e) {
      yield WeatherLoadError(errorMessage: e.toString());
    }
  }

  void dispose() {
    cityBlocSubscription.cancel();
  }
}
