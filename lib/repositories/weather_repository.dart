import 'package:songlyrics/dataproviders/weather_provider.dart';
import 'package:songlyrics/models/custom_exception/city_exception.dart';
import 'package:songlyrics/models/weather.dart';

class WeatherRepository {
  WeatherApi _weatherApi = WeatherApi();

  Future<Weather> fetchWeatherByCityTyped(String cityName) async {
    var source = await _weatherApi.fetchWeatherByCityId(cityName);

    if (source.statusCode == 200) {
      Weather weather = Weather.fromRawJson(source.body);

      return weather;
    } else if (source.statusCode == 400 || source.statusCode == 404) {
      throw CityException(errorMessage: '$cityName not found');
    }
  }

  Future<Weather> fetchWeatherByLocationRepo(
      {double latitude, double longitude}) async {
    var source = await _weatherApi.fectchWeatherByLocationApi(
        long: longitude, lat: latitude);

    Weather weather = Weather.fromRawJson(source.body);

    return weather;
  }

  int stringLengthChecker(String value) {
    if (value.length > 5) {
      return 6;
    } else {
      return 5;
    }
  }
}
