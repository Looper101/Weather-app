import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'city_search_event.dart';
part 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  CitySearchBloc() : super(CitySearchInitial());

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
}
