import 'package:songlyrics/dataproviders/weather_provider.dart';
import 'package:songlyrics/models/custom_exception/city_exception.dart';
import 'package:songlyrics/models/weather.dart';

class WeatherRepository {
  WeatherApi _weatherApi = WeatherApi();

  Future<Weather> fetchWeatherByCityTyped(String cityName) async {
    var source = await _weatherApi.fetchWeatherByCityId(cityName);
    print("status code of the request is: ${source.statusCode} ");
    if (source.statusCode == 200) {
      Weather weather = Weather.fromRawJson(source.body);
      print('Returning the weather coz the city exist');
      return weather;
    } else if (source.statusCode == 400 || source.statusCode == 404) {
      throw CityException(errorMessage: 'City not found');
    }
  }

  Future<Weather> fetchWeatherByLocationRepo(
      {double latitude, double longitude}) async {
    var source = await _weatherApi.fectchWeatherByLocationApi(
        long: longitude, lat: latitude);

    Weather weather = Weather.fromRawJson(source.body);

    return weather;
  }
}
