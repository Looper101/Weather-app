import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

import '../dataproviders/geolocator_provider.dart';

// ignore: must_be_immutable
class GeolocatorRepository extends Equatable {
  Location _location = Location();
  Future<LocationData> getCurrentLocation() async =>
      await _location.getLocation();

  @override
  List<Object> get props => [];

  // GeolocatorApi _geolocatorApi;

  // ///Returns a future of LocationPermission--Permission check
  // Future<LocationPermission> checkPermission() async =>
  //     _geolocatorApi.checkPermission();

  // ///Ask for permission from User
  // Future<LocationPermission> getPermission() async =>
  //     _geolocatorApi.getPermission();

  // ///Get current Location of the user
  // Future<Position> getCurrentLocation() async =>
  //     await _geolocatorApi.getCurrentLocation();

  // Stream<Position> onPositionChanged() async* {
  //   yield* _geolocatorApi.onPositionChange();
  // }
}
