part of 'city_search_bloc.dart';

abstract class CitySearchState {
  const CitySearchState();
  // @override
  // List<Object> get props => [];
}

class CitySearchInitial extends CitySearchState {
  const CitySearchInitial();
  // @override
  // List<Object> get props => [];
}

class CitySearchLoading extends CitySearchState {}

class CityLoaded extends CitySearchState {
  final String cityTyped;

  CityLoaded(this.cityTyped);
  //
  // @override
  // List<Object> get props => [cityTyped];
  //
  // @override
  // String toString() => 'CitySearchSearch(city: $cityTyped)';
}

//

class CitySearchError extends CitySearchState {
  final String errorMessage;
  CitySearchError({
    this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
