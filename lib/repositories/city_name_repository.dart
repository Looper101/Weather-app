import 'dart:convert';

import 'package:http/http.dart';
import 'package:songlyrics/dataproviders/city_name_provider.dart';
import 'package:songlyrics/models/weather_forecast.dart';

class CityNameRepo {
  CityNameProvider _cityNameProvider;

  Future fetchCityName(String name) async {
    Response response = await _cityNameProvider.fetchCityName(name);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      City city = City.fromJson(decodedData);
      print('City loaded');
      print('City is $city');
      return city;
    }
  }
}
