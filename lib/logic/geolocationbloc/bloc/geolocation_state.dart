part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

class GeolocationInitial extends GeolocationState {}

class GeolocationLoading extends GeolocationState {}

class GeolocationLoaded extends GeolocationState {
  final geo.LocationResult position;
  GeolocationLoaded({
    this.position,
  });

  @override
  List<Object> get props => [position];
}

class GeolocationLoadError extends GeolocationState {
  final String errorMessage;
  GeolocationLoadError({
    this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
