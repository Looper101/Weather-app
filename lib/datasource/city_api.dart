import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class CityApi {
  ///!Fetch weather by typed city-name
  Future<String> getCityIdByQuery(String cityName) async {
    String url =
        "https://www.metaweather.com/api/location/search/?query=$cityName";

    http.Response response = await http.get(url);
    return response.body;
  }

  ///!Fetch weather data using user current coordinate(location)
  Future<String> getCityIdByLocation(LocationData loc) async {
    String url =
        "https://www.metaweather.com/api/location/search/?lattlong=${loc.longitude},${loc.latitude}";

    http.Response response = await http.get(url);

    return response.body;
  }
}
