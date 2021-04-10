import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:songlyrics/models/city_id.dart';
import 'package:songlyrics/repositories/cityId_repository.dart';

part 'city_search_event.dart';
part 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final CityIdRepository cityIdRepository;

  CitySearchBloc(
    this.cityIdRepository,
  ) : super(CitySearchInitial());

// @override
//   Stream<Transition<CitySearchEvent, CitySearchState>> transformEvents(Stream<CitySearchEvent> events, transitionFn) {

//     // return super.transformEvents(events, transitionFn);
//   }
  @override
  Stream<Transition<CitySearchEvent, CitySearchState>> transformEvents(
      Stream<CitySearchEvent> events, transitionFn) {
    final nonDebounceStream = events.where((event) => event is! CitySearched);

    final debounceStream = events
        .where((event) => event is CitySearched)
        .debounceTime(Duration(milliseconds: 500));

    return super.transformEvents(
        MergeStream([debounceStream, nonDebounceStream]), transitionFn);
  }

  @override
  Stream<CitySearchState> mapEventToState(
    CitySearchEvent event,
  ) async* {
    if (event is CitySearched) {
      yield* _mapCitySearchEventToMap(event);
    }

    if (event is CitySelected) {
      yield* _mapCityPickedToState(event);
    }
    if (event is CityInvalidTyped) {
      yield* _mapCityInvalidTypedToState(event);
    }
  }

  Stream<CitySearchState> _mapCitySearchEventToMap(CitySearched event) async* {
    try {
      yield CitySearchLoading();
      City result = await cityIdRepository.getCityIdByCityTyped(event.query);
      print('result from city typed: ${result.cities.length}');
      yield CitySearchLoaded(result);
    } catch (e) {
      yield CitySearchError(errorMessage: e);
    }
  }

  Stream<CitySearchState> _mapCityPickedToState(CitySelected event) async* {
    try {
      yield CityPicked(selectedCity: event.cityId);
    } catch (e) {
      yield CitySearchError(errorMessage: e);
    }
  }

  Stream<CitySearchState> _mapCityInvalidTypedToState(
      CityInvalidTyped event) async* {
    yield CitySearchError(
        errorMessage: '${event.cityTyped} is not a valid city');
  }

  void dispose() {}
}

//  Stream<Transition<Event, State>> transformEvents(
//     Stream<Event> events,
//     TransitionFunction<Event, State> transitionFn,
//   ) {
//     return events.asyncExpand(transitionFn);
//   }

//   /// Must be implemented when a class extends [Bloc].
//   /// [mapEventToState] is called whenever an [event] is [add]ed
//   /// and is responsible for converting that [event] into a new [state].
//   /// [mapEventToState] can `yield` zero, one, or multiple states for an event.

// @override
//   Stream<Transition< GithubSearchEvent, GithubSearchState >> transformEvents(
//       Stream< GithubSearchEvent > events, transitionFn) {
//     return events
//         .debounceTime(const Duration(milliseconds: 500))
//         .switchMap((transitionFn));
//   }
