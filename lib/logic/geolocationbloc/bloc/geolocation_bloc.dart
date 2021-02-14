import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:songlyrics/models/position_model.dart';

import 'package:songlyrics/repositories/geolocator_repository.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocatorRepository geolocatorRepository;

  PositionModel _positionModel = PositionModel();
  StreamSubscription _streamSubscription;
  GeolocationBloc({this.geolocatorRepository}) : super(null) {
    _streamSubscription =
        this.geolocatorRepository.onPositionChanged().listen((newPosition) {
      _positionModel = PositionModel(
          latitude: newPosition.latitude, longitude: newPosition.longitude);
      add(LocationChanged(position: _positionModel));
    });
  }

  @override
  Stream<GeolocationState> mapEventToState(
    GeolocationEvent event,
  ) async* {
    if (event is FindLocation) {
      yield* _mapFindLocationToState();
    }
    if (event is LocationChanged) {
      yield* _mapLocationChanged(event);
    }
  }

  Stream<GeolocationState> _mapFindLocationToState() async* {
    try {
      yield GeolocationLoading();

      var finalPosition = await geolocatorRepository.getCurrentLocation();

      yield GeolocationLoaded(position: finalPosition);
    } catch (e) {
      yield GeolocationLoadError(errorMessage: e.toString());
    }
  }

  Stream<GeolocationState> _mapLocationChanged(LocationChanged event) async* {
    try {
      if (state is GeolocationLoaded) {
        yield GeolocationLoaded(
            position: PositionModel().copyWith(event.position));
      }
    } catch (e) {
      yield GeolocationLoadError(errorMessage: e.toString());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
