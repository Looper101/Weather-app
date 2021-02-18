import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:songlyrics/logic/geolocationbloc/bloc/geolocation_bloc.dart';
import 'package:songlyrics/models/weather_forecast.dart';
import 'package:songlyrics/repositories/weather_forecast_repository.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  GeolocationBloc geolocationBloc;
  WeatherForecastRepository weatherForecastRepository;
  ForecastBloc({this.geolocationBloc, this.weatherForecastRepository})
      : super(ForecastInitial()) {
    geolocationBloc.listen((state) {
      if (state is GeolocationLoaded) {
        add(ForecastFetched(locationData: state.position));
      }
    });
  }
  // StreamSubscription _locationStreamSubscription;

  @override
  Stream<ForecastState> mapEventToState(
    ForecastEvent event,
  ) async* {
    if (event is ForecastFetched) {
      yield* _mapForecastFetchedToState(event);
    }
  }

  Stream<ForecastState> _mapForecastFetchedToState(
      ForecastFetched event) async* {
    if (state is ForecastLoaded) {
      try {
        WeatherForecast result = await weatherForecastRepository
            .getWeatherForecastData(event.locationData);
        print(result.dataList);
        yield ForecastLoaded(
            weatherForecast: WeatherForecast().copyWith(
                cod: result.cod,
                message: result.message,
                dataList: result.dataList));
      } catch (e) {
        yield ForeCastLoadError(message: e.toString());
      }
    }
    try {
      WeatherForecast result = await weatherForecastRepository
          .getWeatherForecastData(event.locationData);
      yield ForecastLoaded(weatherForecast: result);
    } catch (e) {
      yield ForeCastLoadError(message: e.toString());
    }
  }
}
