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
  final GeolocationBloc geolocationBloc;
  final WeatherForecastRepository weatherForecastRepository;
  ForecastBloc({this.geolocationBloc, this.weatherForecastRepository})
      : super(ForecastInitial()) {
    _locationStreamSubscription = geolocationBloc.listen((state) {
      if (state is GeolocationLoaded) {
        add(ForecastFetched(locationData: state.position));
      }
    });
  }
  StreamSubscription _locationStreamSubscription;

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
    yield ForecastLoading();
    try {
      Forecast result = await weatherForecastRepository
          .getWeatherForecastData(event.locationData);
      yield ForecastLoaded(weatherForecast: result);
    } catch (e) {
      yield ForeCastLoadError(message: e.toString());
    }
  }

  @override
  Future<void> close() {
    _locationStreamSubscription.cancel();
    return super.close();
  }
}
