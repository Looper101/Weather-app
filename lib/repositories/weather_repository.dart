import 'package:songlyrics/dataproviders/weather_provider.dart';
import 'package:songlyrics/models/weather.dart';

class WeatherRepository {
  WeatherApi _weatherApi = WeatherApi();

  Future<Weather> fetchWeatherByCityTyped(String cityName) async {
    String source = await _weatherApi.fetchWeatherByCityId(cityName);

    Weather weather = Weather.fromRawJson(source);
    return weather;
  }

  Future<Weather> fetchWeatherByLocationRepo(
      {double latitude, double longitude}) async {
    String source = await _weatherApi.fectchWeatherByLocationApi(
        long: longitude, lat: latitude);

    Weather weather = Weather.fromRawJson(source);

    return weather;
  }
}
