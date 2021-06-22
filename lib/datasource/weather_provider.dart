import 'package:http/http.dart' as http;

class WeatherApi {
  final String appId = 'dd2802091dc6f5d51f064d6ce8fb8441';
  Future<http.Response> fetchWeatherByCityId(String cityName) async {
    print('fetching data from API');

    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$appId&units=metric';

    http.Response response = await http.get(url);

    return response;
  }

  Future<http.Response> fectchWeatherByLocationApi(
      {double long, double lat}) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$appId&units=metric';
    http.Response response = await http.get(url);

    return response;
  }
}
