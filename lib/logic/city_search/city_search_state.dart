part of 'city_search_bloc.dart';

abstract class CitySearchState extends Equatable {
  const CitySearchState();

  @override
  List<Object> get props => [];
}

class CitySearchInitial extends CitySearchState {}

class CitySearchLoading extends CitySearchState {}

class CitySearchLoaded extends CitySearchState {
  final CityName city;
  CitySearchLoaded({
    this.city,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CitySearchLoaded && other.city == city;
  }

  @override
  int get hashCode => city.hashCode;
}

class CitySearchError extends CitySearchState {
  final String errorMessage;
  CitySearchError({
    this.errorMessage,
  });
}
