import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class WeatherForeCastApi {
  final String apiKey = 'dd2802091dc6f5d51f064d6ce8fb8441';
  Future<String> getWeatherForecastData(LocationData loc) async {
    String forecastUrl =
        "https://api.openweathermap.org/data/2.5/forecast?lat=${loc.latitude}&lon=${loc.longitude}&appid=$apiKey";

    http.Response response = await http.get(forecastUrl);

    return response.body;
  }
}
