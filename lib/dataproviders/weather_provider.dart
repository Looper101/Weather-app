import 'package:http/http.dart' as http;
import 'package:songlyrics/models/city_id.dart';

class WeatherApi {
  Future<String> fetchWeatherByCityId(CityId cityId) async {
    String url = 'api link goes here?cityId = ${cityId.woeId}';

    http.Response response = await http.get(url);
    return response.body;
  }

  Future<String> fectchWeatherByLocation({double long, double lat}) async {
    String url = 'api link goes here=$long+$lat';

    http.Response response = await http.get(url);

    return response.body;
  }
}
