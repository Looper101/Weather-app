part of 'city_search_bloc.dart';

abstract class CitySearchState extends Equatable {
  const CitySearchState();

  @override
  List<Object> get props => [];
}

class CitySearchInitial extends CitySearchState {}

class CitySearchLoading extends CitySearchState {}

class CitySearchLoaded extends CitySearchState {
  final City city;

  CitySearchLoaded(this.city);

  @override
  String toString() => 'CitySearchLoaded(city: $city)';

  @override
  List<Object> get props => [city];
}

class CitySearchSelected extends CitySearchState {
  final CityId cityId;
  CitySearchSelected({
    this.cityId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CitySearchSelected && other.cityId == cityId;
  }

  @override
  int get hashCode => cityId.hashCode;
}

class CityPicked extends CitySearchState {
  final CityId selectedCity;
  CityPicked({
    this.selectedCity,
  });

  @override
  List<Object> get props => [selectedCity];
}

class CitySearchError extends CitySearchState {
  final String errorMessage;
  CitySearchError({
    this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
