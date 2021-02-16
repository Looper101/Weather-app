part of 'geolocation_bloc.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();

  @override
  List<Object> get props => [];
}

class FindLocation extends GeolocationEvent {}

class LocationChanged extends GeolocationEvent {
  final geo.LocationResult position;
  LocationChanged({
    this.position,
  });

  @override
  List<Object> get props => [position];
}
