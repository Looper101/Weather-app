part of 'forecast_bloc.dart';

abstract class ForecastState extends Equatable {
  const ForecastState();

  @override
  List<Object> get props => [];
}

class ForecastInitial extends ForecastState {}

class ForecastLoading extends ForecastState {}

class ForeCastLoadError extends ForecastState {
  final String message;
  ForeCastLoadError({this.message});

  @override
  List<Object> get props => [message];
}

class ForecastLoaded extends ForecastState {
  final Forecast weatherForecast;
  ForecastLoaded({
    this.weatherForecast,
  });

  @override
  List<Object> get props => [weatherForecast];
}
