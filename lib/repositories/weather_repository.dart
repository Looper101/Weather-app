import 'package:songlyrics/datasource/weather_provider.dart';

import '../error/exception/city_exception.dart';
import '../models/weather.dart';

class WeatherRepository {
  WeatherApi _weatherApi = WeatherApi();

  WeatherRepository(WeatherApi weatherApi);

  // ignore: missing_return
  Future<Weather> fetchWeatherByCityTyped(String cityName) async {
    var source = await _weatherApi.fetchWeatherByCityId(cityName);

    if (source.statusCode == 200) {
      Weather weather = Weather.fromRawJson(source.body);
      print(weather);
      return weather;
    } else if (source.statusCode == 400 || source.statusCode == 404) {
      throw CityException(errorMessage: '$cityName not found');
    }
  }

  Future<Weather> fetchWeatherByLocationRepo(
      {double latitude, double longitude}) async {
    print('trying to fetch weather in repo');
    print('Coordinate:$longitude: $latitude');
    var source = await _weatherApi.fectchWeatherByLocationApi(
        long: longitude, lat: latitude);
    print(source);
    Weather weather = Weather.fromRawJson(source.body);

    return weather;
  }
}
