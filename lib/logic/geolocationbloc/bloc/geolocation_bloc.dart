import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_geolocation/geolocation.dart' as geo;
part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  // PositionModel _positionModel;
  // StreamSubscription _streamSubscription;
  // GeolocationBloc({this.geolocatorRepository}) : super(GeolocationInitial()) {
  //   _streamSubscription =
  //       this.geolocatorRepository.onPositionChanged().listen((newPosition) {
  //     print("GEOLOCATIONBLOC newposition:$newPosition");
  //     _positionModel = PositionModel(
  //         latitude: newPosition.latitude, longitude: newPosition.longitude);
  //     add(LocationChanged(position: _positionModel));
  //   });
  // }
  final Geolocator _geolocator;
  StreamSubscription _locationStreamSubscription;
  GeolocationBloc({@required Geolocator geolocator})
      : assert(geolocator != null),
        _geolocator = geolocator,
        super(GeolocationInitial());

  @override
  Stream<GeolocationState> mapEventToState(
    GeolocationEvent event,
  ) async* {
    if (event is FindLocation) {
      yield* _mapFindLocationToState();
    } else if (event is LocationChanged) {
      yield GeolocationLoaded(position: event.position);
    }
    // if (event is LocationChanged) {
    //   yield* _mapLocationChanged(event);
    // }
  }

  Stream<GeolocationState> _mapFindLocationToState() async* {
    yield GeolocationLoading();

    // _locationStreamSubscription?.cancel();
    // _locationStreamSubscription = Geolocator.getPositionStream().listen(
    //     (Position position) => add(LocationChanged(position: position)));
    try {
      // var position = await Geolocator.getCurrentPosition(
      //     forceAndroidLocationManager: true,
      //     desiredAccuracy: LocationAccuracy.low);
      // yield GeolocationLoaded(position: position);
      _locationStreamSubscription?.cancel();
      _locationStreamSubscription =
          geo.Geolocation.currentLocation(accuracy: geo.LocationAccuracy.best)
              .listen((event) {
        add(LocationChanged(position: event));
      });
    } catch (e) {
      yield GeolocationLoadError(errorMessage: e.toString());
    }
  }

  // Stream<GeolocationState> _mapLocationChanged(LocationChanged event) async* {
  //   try {
  //     if (state is GeolocationLoaded) {
  //       yield GeolocationLoaded(
  //           position: PositionModel().copyWith(event.position));
  //     }
  //   } catch (e) {
  //     yield GeolocationLoadError(errorMessage: e.toString());
  //   }
  // }

  @override
  Future<void> close() {
    _locationStreamSubscription.cancel();
    return super.close();
  }
}
