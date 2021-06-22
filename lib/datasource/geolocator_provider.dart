import 'package:location/location.dart';

class GeolocatorApi {
  Location _location;

  Future<LocationData> getCurrentLocation() async =>
      await _location.getLocation();
}
