import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

// ignore: must_be_immutable
class GeolocatorRepository extends Equatable {
  Location _location = Location();
  Future<LocationData> getCurrentLocation() async =>
      await _location.getLocation();

  @override
  List<Object> get props => [_location];
}
