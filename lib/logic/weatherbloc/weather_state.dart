import 'package:equatable/equatable.dart';
import '../../models/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  WeatherLoaded({
    this.weather,
  });

  @override
  List<Object> get props => [weather];

  @override
  String toString() => 'WeatherLoaded(weather: $weather)';
}

class WeatherLoadError extends WeatherState {
  final String cityName;
  final dynamic errorMessage;
  WeatherLoadError({
    this.errorMessage,
    this.cityName,
  });

  @override
  List<Object> get props => [errorMessage, cityName];

  @override
  String toString() =>
      'WeatherLoadError(errorMessage: $errorMessage,cityName:$cityName)';
}

class WeatherLoadCityException extends WeatherState {
  final String message;
  WeatherLoadCityException(
    this.message,
  );
  @override
  List<Object> get props => [message];
}

class CitySearched extends WeatherState {
  final String cityName;
  CitySearched({this.cityName});

  @override
  List<Object> get props => [cityName];
}
