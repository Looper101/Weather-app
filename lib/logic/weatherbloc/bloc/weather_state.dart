part of 'weather_bloc.dart';

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
  final dynamic errorMessage;
  WeatherLoadError({
    this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'WeatherLoadError(errorMessage: $errorMessage)';
}

class WeatherLoadCityException extends WeatherState {
  final String message;
  WeatherLoadCityException(this.message);
  @override
  List<Object> get props => [message];
}
