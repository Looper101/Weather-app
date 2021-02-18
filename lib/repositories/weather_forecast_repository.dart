import 'package:location/location.dart';
import 'package:songlyrics/dataproviders/weather_forecast.dart';
import 'package:songlyrics/models/weather_forecast.dart';

class WeatherForecastRepository {
  WeatherForeCastApi _weatherForeCastApi;

  Future<WeatherForecast> getWeatherForecastData(LocationData loc) async {
    String result = await _weatherForeCastApi.getWeatherForecastData(loc);

    WeatherForecast weatherForecast = WeatherForecast.fromJson(result);
    return weatherForecast;
  }
}
