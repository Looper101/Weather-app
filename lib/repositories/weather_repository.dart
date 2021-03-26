import 'dart:convert';

import 'package:location/location.dart';
import 'package:songlyrics/dataproviders/weather_provider.dart';
import 'package:songlyrics/models/city_id.dart';
import 'package:songlyrics/models/weather.dart';

class WeatherRepository {
  WeatherApi _weatherApi;

  Future<Weather> fetchWeatherByCityId(CityId cityId) async {
    var source = await _weatherApi.fectchWeatherByCityId(cityId);

    Weather weather = Weather.fromRawJson(source);
    return weather;
  }

  Future<Weather> fetchWeatherByLocation(LocationData loc) async {
    var result = await _weatherApi.fectchWeatherByLocation(
        long: loc.longitude, lat: loc.latitude);

    Weather weather = Weather.fromRawJson(result);
    return weather;
  }
}
