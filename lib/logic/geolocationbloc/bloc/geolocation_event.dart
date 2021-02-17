import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart' as geo;

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();

  @override
  List<Object> get props => [];
}

class FindLocation extends GeolocationEvent {}

class LocationChanged extends GeolocationEvent {
  final geo.Position position;
  LocationChanged({
    this.position,
  });

  @override
  List<Object> get props => [position];
}
