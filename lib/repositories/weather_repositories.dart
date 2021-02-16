import 'package:geolocator/geolocator.dart';
import 'package:songlyrics/dataproviders/weather_api_provider.dart';
import 'package:songlyrics/models/location.dart';
import 'package:songlyrics/models/position_model.dart';
import 'package:songlyrics/models/weather.dart';

class WeatherRepository {
  WeatherApi weatherApi = WeatherApi();

  /// Fetch weather data by the user typed city name ex-. London
  Future<Weather> getWeatherData(String query) async {
    String rawWeather = await weatherApi.getRawData(query);
    Weather weather = Weather.fromJson(rawWeather);

    return weather;
  }

  ///Fetch weather data by using user current location-i.e Co-ordinates
  Future<Weather> fetchWeatherByLocation(Position location) async {
    String rawWeather = await weatherApi.weatherDataForLocation(location);

    Weather weather = Weather.fromJson(rawWeather);
    return weather;
  }
}
