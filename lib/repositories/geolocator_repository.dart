import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

class GeolocatorRepository extends Equatable {
  final Location _location;

  GeolocatorRepository(this._location) : assert(_location != null);
  Future<LocationData> getCurrentLocation() async =>
      await _location.getLocation();

  @override
  List<Object> get props => [_location];
}
