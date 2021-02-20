import 'package:location/location.dart';
import 'package:songlyrics/dataproviders/weather_forecast.dart';
import 'package:songlyrics/models/weather_forecast.dart';

class WeatherForecastRepository {
  WeatherForeCastApi _weatherForeCastApi =
      WeatherForeCastApi(); //Added these to fix the bug

  Future<Forecast> getWeatherForecastData(LocationData loc) async {
    String result = await _weatherForeCastApi.getWeatherForecastData(loc);

    Forecast weatherForecast = Forecast.fromRawJson(result);

    return weatherForecast;
  }
}

//TODO: Fix the error that's being caused by the forecast Bloc
//* */The bug is not allowing the repository to make call/http request
