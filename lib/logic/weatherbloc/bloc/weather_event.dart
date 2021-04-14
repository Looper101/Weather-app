part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

//NOTE: FetchWeatherByLocation event will be called at app launch

//Fetch weather data by typed city
class FetchWeatherByCityTyped extends WeatherEvent {
  final String cityTyped;
  FetchWeatherByCityTyped({
    this.cityTyped,
  });

  @override
  String toString() => 'FetchedWeatherTypedCity(query: $cityTyped)';
  @override
  List<Object> get props => [cityTyped];
}

//fetch weather data by user current location

class FetchWeatherByLocation extends WeatherEvent {
  FetchWeatherByLocation();
}

//notify bloc of an error from other bloc being subscribed to
class FetchWeatherError extends WeatherEvent {
  final String message;
  FetchWeatherError(this.message);
  @override
  List<Object> get props => [message];
}
