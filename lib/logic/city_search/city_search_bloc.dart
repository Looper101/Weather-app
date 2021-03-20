import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:songlyrics/models/city.dart';
import 'package:songlyrics/models/weather_forecast.dart';
import 'package:songlyrics/repositories/city_name_repository.dart';
part 'city_search_event.dart';
part 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  CitySearchBloc(this.cityNameRepo) : super(CitySearchInitial());

  CityNameRepo cityNameRepo;

  @override
  Stream<CitySearchState> mapEventToState(
    CitySearchEvent event,
  ) async* {
    if (event is LoadCity) {
      yield* _mapLoadCityToState(event);
    }
  }

  Stream<CitySearchState> _mapLoadCityToState(LoadCity event) async* {
    try {
      yield CitySearchLoading();

      var result = await cityNameRepo.fetchCityName(event.cityName);
      yield CitySearchLoaded(city: result);
    } catch (e) {
      yield CitySearchError(errorMessage: e.toString());
    }
  }
}
