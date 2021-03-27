import 'package:songlyrics/dataproviders/weather_provider.dart';
import 'package:songlyrics/models/city_id.dart';
import 'package:songlyrics/models/weather.dart';

class WeatherRepository {
  WeatherApi _weatherApi = WeatherApi();

  Future<Weather> fetchWeatherByCityId(CityId cityId) async {
    var source = await _weatherApi.fetchWeatherByCityId(cityId);

    Weather weather = Weather.fromRawJson(source);
    return weather;
  }

  // Future<Weather> fetchWeatherByLocationRepo(
  //     {double latitude, double longitude}) async {
  //   var result = await _weatherApi.fectchWeatherByLocationApi(
  //       long: longitude, lat: latitude);

  //   Weather weather = Weather.fromRawJson(result);

  //   return weather;
  // }
}
