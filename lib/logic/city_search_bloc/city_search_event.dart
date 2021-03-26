part of 'city_search_bloc.dart';

abstract class CitySearchEvent extends Equatable {
  const CitySearchEvent();

  @override
  List<Object> get props => [];
}

class CitySearched extends CitySearchEvent {
  final String query;
  CitySearched({
    this.query,
  });

  @override
  List<Object> get props => [query];
}

class CitySelected extends CitySearchEvent {
  final CityId cityId;
  CitySelected({
    this.cityId,
  });

  @override
  List<Object> get props => [cityId];
}
