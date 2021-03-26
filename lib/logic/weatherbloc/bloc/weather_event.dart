part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

//NOTE: FetchWeatherByLocation event will be called at app launch

//Fetch weather data by typed city
class FetchWeatherByCityId extends WeatherEvent {
  final CityId cityId;
  FetchWeatherByCityId({
    this.cityId,
  });

  @override
  String toString() => 'FetchedWeatherTypedCity(query: $cityId)';
  @override
  List<Object> get props => [cityId];
}

//fecth weather data by user current location

class FetchWeatherByLocation extends WeatherEvent {
  FetchWeatherByLocation();
}
