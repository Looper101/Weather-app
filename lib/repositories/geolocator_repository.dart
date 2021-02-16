// import 'package:geolocator/geolocator.dart';
// import 'package:songlyrics/dataproviders/geolocator_provider.dart';
// import 'package:songlyrics/models/position_model.dart';

// class GeolocatorRepository {
//   GeolocatorApi _geolocatorApi;

//   ///Returns a future of LocationPermission--Permission check
//   Future<LocationPermission> checkPermission() async =>
//       _geolocatorApi.checkPermission();

//   ///Ask for permission from User
//   Future<LocationPermission> getPermission() async =>
//       _geolocatorApi.getPermission();

//   ///Get current Location of the user
//   Future<Position> getCurrentLocation() async =>
//       await _geolocatorApi.getCurrentLocation();

//   Stream<Position> onPositionChanged() async* {
//     yield* _geolocatorApi.onPositionChange();
//   }
// }
