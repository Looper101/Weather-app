import 'package:geolocator/geolocator.dart';
import 'package:songlyrics/dataproviders/geolocator_provider.dart';
import 'package:songlyrics/models/position_model.dart';

class GeolocatorRepository {
  GeolocatorApi _geolocatorApi;

  checkPermission() async => _geolocatorApi.geolocatorPermission;

  Future<PositionModel> getCurrentLocation() async {
    Position position = await _geolocatorApi.getCurrentLoaction();

    PositionModel positionModel = PositionModel(
        latitude: position.latitude, longitude: position.longitude);
    print('Position:=>>>$positionModel');
    return positionModel;
  }

  Stream<Position> onPositionChanged() async* {
    yield* _geolocatorApi.onPositionChange();
  }
}
