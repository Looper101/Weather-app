part of 'city_search_bloc.dart';

abstract class CitySearchEvent extends Equatable {
  const CitySearchEvent();

  @override
  List<Object> get props => [];
}

class CitySearching extends CitySearchEvent {
  final String cityTyped;
  CitySearching(
    this.cityTyped,
  );

  @override
  List<Object> get props => [cityTyped];
}

class InvalidCityTyped extends CitySearchEvent {
  final String cityTyped;
  InvalidCityTyped({this.cityTyped});
  @override
  List<Object> get props => [cityTyped];
}
