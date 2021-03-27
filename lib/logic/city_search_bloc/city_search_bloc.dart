import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:songlyrics/models/city_id.dart';
import 'package:songlyrics/repositories/cityId_repository.dart';

part 'city_search_event.dart';
part 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final CityIdRepository cityIdRepository;

  CitySearchBloc(
    this.cityIdRepository,
  ) : super(CitySearchInitial());

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
  }

  Stream<CitySearchState> _mapCitySearchEventToMap(CitySearched event) async* {
    try {
      yield CitySearchLoading();
      City result = await cityIdRepository.getCityIdByCityTyped(event.query);
      print(result);
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
}
