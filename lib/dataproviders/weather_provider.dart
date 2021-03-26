import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:songlyrics/models/city_id.dart';

class WeatherApi {
  //Fetch weather by cityid;

  Future<String> fectchWeatherByCityId(CityId cityId) async {
    ///TODO:Add api link
    String url = 'api link goes here';

    http.Response response = await http.get(url);
    return response.body;
  }

  Future<String> fectchWeatherByLocation({double long, double lat}) async {
    ///TODO:Add api link
    String url = 'api link goes here';

    http.Response response = await http.get(url);
    return response.body;
  }
}
