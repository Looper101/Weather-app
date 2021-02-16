// import 'package:geolocator/geolocator.dart' as geo;
// import 'package:geolocator/geolocator.dart';

// class GeolocatorApi {
//   ///Returns a future of LocationPermission--Permission check
//   Future<geo.LocationPermission> checkPermission() async =>
//       await geo.Geolocator.checkPermission();

//   ///Ask for permission from User
//   Future<geo.LocationPermission> getPermission() async {
//     var permissionResult = geo.Geolocator.requestPermission();
//     return permissionResult;
//   }

//   ///Get current location
//   Future<Position> getCurrentLocation() async {
//     geo.Position position = await geo.Geolocator.getCurrentPosition(
//         desiredAccuracy: geo.LocationAccuracy.bestForNavigation);
//     print(position);
//     return position;
//   }

//   ///Stream of position whenever user changes position
//   Stream<geo.Position> onPositionChange() async* {
//     yield* geo.Geolocator.getPositionStream(
//         desiredAccuracy: geo.LocationAccuracy.best);
//   }
// }
