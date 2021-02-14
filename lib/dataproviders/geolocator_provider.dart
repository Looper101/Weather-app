import 'package:geolocator/geolocator.dart' as geo;

class GeolocatorApi {
  geo.LocationPermission _permission;

  ///get geolocator permisiion status of the app
  geo.LocationPermission get geolocatorPermission => _permission;

  ///Get current location
  Future getCurrentLoaction() async {
    geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
    return position;
  }

  ///Stream of position whenever user changes position
  Stream<geo.Position> onPositionChange() async* {
    yield* geo.Geolocator.getPositionStream(
        desiredAccuracy: geo.LocationAccuracy.high);
  }
}
