import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

//TODO: Equatable shouldn't be here

// ignore: must_be_immutable
class GeolocatorRepository extends Equatable {
  Location _location = Location();
  Future<LocationData> getCurrentLocation() async =>
      await _location.getLocation();

  @override
  List<Object> get props => [_location];
}
