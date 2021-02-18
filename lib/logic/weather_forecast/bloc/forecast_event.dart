part of 'forecast_bloc.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent();

  @override
  List<Object> get props => [];
}

class ForecastFetched extends ForecastEvent {
  final LocationData locationData;
  ForecastFetched({
    this.locationData,
  });

  @override
  List<Object> get props => [locationData];
}
