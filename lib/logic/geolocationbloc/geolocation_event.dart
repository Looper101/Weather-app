import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();

  @override
  List<Object> get props => [];
}

class FindLocation extends GeolocationEvent {}

class LocationChanged extends GeolocationEvent {
  final LocationData position;
  LocationChanged({
    this.position,
  });

  @override
  List<Object> get props => [position];
}
