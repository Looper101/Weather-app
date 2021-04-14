import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class CityIdApi {
  // final String apiKey = 'dd2802091dc6f5d51f064d6ce8fb8441';

//Fetch weather data by using typed city query
  Future<String> getCityIdByQuery(String cityName) async {
    String url =
        "https://www.metaweather.com/api/location/search/?query=$cityName";

    http.Response response = await http.get(url);
    return response.body;
  }

  //Fetch weather data using user current coordinate(location)
  Future<String> getCityIdByLocation(LocationData loc) async {
    String url =
        "https://www.metaweather.com/api/location/search/?lattlong=${loc.longitude},${loc.latitude}";

    http.Response response = await http.get(url);

    return response.body;
  }
}
