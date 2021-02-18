import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
// as geo;
import 'package:songlyrics/logic/geolocationbloc/bloc/geolocation_event.dart';
import 'package:songlyrics/repositories/geolocator_repository.dart';
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

  final GeolocatorRepository geolocatorRepository;
  GeolocationBloc({this.geolocatorRepository}) : super(GeolocationInitial());

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

    try {
      LocationData locationData =
          await geolocatorRepository.getCurrentLocation();

      add(LocationChanged(position: locationData));
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

}
