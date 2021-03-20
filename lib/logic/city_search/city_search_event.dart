part of 'city_search_bloc.dart';

abstract class CitySearchEvent extends Equatable {
  const CitySearchEvent();

  @override
  List<Object> get props => [];
}

class LoadCity extends CitySearchEvent {
  final String cityName;
  LoadCity({
    this.cityName,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadCity && other.cityName == cityName;
  }

  @override
  int get hashCode => cityName.hashCode;
}
