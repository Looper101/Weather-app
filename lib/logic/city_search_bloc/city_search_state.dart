part of 'city_search_bloc.dart';

abstract class CitySearchState extends Equatable {
  const CitySearchState();

  @override
  List<Object> get props => [];
}

class CitySearchInitial extends CitySearchState {}

class CitySearchLoading extends CitySearchState {}

class CityLoaded extends CitySearchState {
  final String cityTyped;

  CityLoaded(this.cityTyped);

  @override
  String toString() => 'CitySearchSearch(city: $cityTyped)';

  @override
  List<Object> get props => [cityTyped];
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
