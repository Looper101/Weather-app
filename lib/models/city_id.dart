import 'dart:convert';

import 'package:flutter/foundation.dart';

class City {
  List<CityId> cities;
  City({
    @required this.cities,
  });

  factory City.fromJson(String string) {
    return City(cities: cityList(string));
  }

  static List<CityId> cityList(String str) {
    return List.from(jsonDecode(str)).map((e) => CityId.fromJson(e)).toList();
  }
}

class CityId {
  final int distance;
  final String cityName;
  final int woeId;
  final String coordinate;

  CityId({
    @required this.distance,
    @required this.cityName,
    @required this.woeId,
    @required this.coordinate,
  });

  factory CityId.fromJson(Map<String, dynamic> json) {
    return CityId(
      distance: json['distance'],
      cityName: json['title'],
      woeId: json['woeid'],
      coordinate: json['latt_long'],
    );
  }
}
