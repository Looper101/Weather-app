import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:location/location.dart';

import 'barrel.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  GeolocationBloc(this.location)
      : assert(location != null),
        super(GeolocationInitial()) {
    locationStream = location.onLocationChanged.listen((event) {
      add(LocationChanged(position: event));
    });
  }

  StreamSubscription locationStream;
  final Location location;
  @override
  Stream<GeolocationState> mapEventToState(
    GeolocationEvent event,
  ) async* {
    if (event is FindLocation) {
      yield* _mapFindLocationToState();
    } else if (event is LocationChanged) {
      yield GeolocationLoaded(position: event.position);
    }
  }

  Stream<GeolocationState> _mapFindLocationToState() async* {
    yield GeolocationLoading();

    try {
      locationStream = location.onLocationChanged.listen((event) {
        add(LocationChanged(position: event));
      });
    } catch (e) {
      yield GeolocationLoadError(errorMessage: e.toString());
    }
  }

  @override
  Future<void> close() {
    locationStream.cancel();
    return super.close();
  }
}
