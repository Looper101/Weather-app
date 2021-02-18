import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class WeatherApi {
  final apiKey = 'dd2802091dc6f5d51f064d6ce8fb8441';

  ///Fetch weather data by using the typed in city name--WeatherProvider
  Future<String> getRawData(String city) async {
    final String baseUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

    http.Response response = await http.get(baseUrl);
    return response.body;
  }

  ///Fetch weather data from serve using user location--WeatherProvider
  Future<String> weatherDataForLocation(LocationData loc) async {
    String baseUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=${loc.latitude}&lon=${loc.longitude}&appid=$apiKey";

    http.Response response = await http.get(baseUrl);

    return response.body;
  }
}

//TODO: check the base urls if its working for real
//NOTE: Never ever manipulate the data to instance of models here
//Only return the raw Data fetched from the Api
