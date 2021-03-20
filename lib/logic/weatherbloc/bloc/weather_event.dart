part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

//NOTE: FetchWeatherByLocation event will be called at app launch

//Fetch weather data by typed city
class FetchedWeatherTypedCity extends WeatherEvent {
  final String query;
  FetchedWeatherTypedCity({
    this.query,
  });

  @override
  String toString() => 'FetchedWeatherTypedCity(query: $query)';
  @override
  List<Object> get props => [query];
}

//fecth weather data by user current location

class FetchWeatherByLocation extends WeatherEvent {
  FetchWeatherByLocation();
}
