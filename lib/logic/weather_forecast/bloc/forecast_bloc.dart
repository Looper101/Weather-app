import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:songlyrics/models/weather_forecast.dart';
import 'package:songlyrics/repositories/geolocator_repository.dart';
import 'package:songlyrics/repositories/weather_forecast_repository.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final GeolocatorRepository geolocatorRepository;
  final WeatherForecastRepository weatherForecastRepository;

  ForecastBloc({this.weatherForecastRepository, this.geolocatorRepository})
      : super(ForecastInitial());

  @override
  Stream<ForecastState> mapEventToState(
    ForecastEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapForecastFetchedToState();
    }
  }

  Stream<ForecastState> _mapForecastFetchedToState() async* {
    yield ForecastLoading();
    try {
      var _geolocationResult = await geolocatorRepository.getCurrentLocation();

      Forecast result = await weatherForecastRepository
          .getWeatherForecastData(_geolocationResult);
      yield ForecastLoaded(weatherForecast: result);
    } catch (e) {
      yield ForeCastLoadError(message: e.toString());
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
