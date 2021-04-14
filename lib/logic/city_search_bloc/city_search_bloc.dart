import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'city_search_event.dart';
part 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  CitySearchBloc() : super(CitySearchInitial());

// @override
//   Stream<Transition<CitySearchEvent, CitySearchState>> transformEvents(Stream<CitySearchEvent> events, transitionFn) {

//     // return super.transformEvents(events, transitionFn);
//   }
//   @override
//   Stream<Transition<CitySearchEvent, CitySearchState>> transformEvents(
//       Stream<CitySearchEvent> events, transitionFn) {
//     final nonDebounceStream = events.where((event) => event is! CitySearching);
//
//     final debounceStream = events
//         .where((event) => event is CitySearching)
//         .debounceTime(Duration(milliseconds: 500));
//
//     return super.transformEvents(
//         MergeStream([debounceStream, nonDebounceStream]), transitionFn);
//   }

  @override
  Stream<CitySearchState> mapEventToState(
    CitySearchEvent event,
  ) async* {
    if (event is CitySearching) {
      yield* _mapCitySearchEventToMap(event);
    }
  }

  Stream<CitySearchState> _mapCitySearchEventToMap(CitySearching event) async* {
    try {
      yield CityLoaded(event.cityTyped);
    } catch (e) {
      yield CitySearchError(errorMessage: e);
    }
  }

  void dispose() {}
}
