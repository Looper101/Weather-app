import 'package:http/http.dart' as http;
import 'package:songlyrics/models/city_id.dart';

class WeatherApi {
  Future<String> fetchWeatherByCityId(CityId cityId) async {
    String url = 'https://www.metaweather.com/api/location/${cityId.woeId}/#';

    http.Response response = await http.get(url);
    return response.body;
  }

  Future<String> fectchWeatherByLocationApi({double long, double lat}) async {
    String url =
        'https://www.metaweather.com/api/location/search/?lattlong=36.96,-122.02';

    http.Response response = await http.get(url);

    return response.body;
  }
}

// https://www.metaweather.com/api/location/search/?lattlong=36.96,-122.02
