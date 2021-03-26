import 'package:http/http.dart' as http;
import 'package:location/location.dart';

// class WeatherApiREduntant {
//   // final apiKey = 'dd2802091dc6f5d51f064d6ce8fb8441';

//   ///Fetch weather data by using the typed in city name--WeatherProvider
//   Future<String> getRawData(String city) async {
//     final String baseUrl =
//         'https://api.openweathermap.org/data/2.5/weather?q=$city&units=imperial&appid=$apiKey';

//     http.Response response = await http.get(baseUrl);
//     return response.body;
//   }

//   ///Fetch weather data from serve using user location--WeatherProvider
//   Future<String> weatherDataForLocation(LocationData loc) async {
//     String baseUrl =
//         "https://api.openweathermap.org/data/2.5/weather?lat=${loc.latitude}&lon=${loc.longitude}&appid=$apiKey";

//     http.Response response = await http.get(baseUrl);

//     return response.body;
//   }
// }

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
