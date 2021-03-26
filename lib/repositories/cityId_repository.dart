import 'package:location/location.dart';
import 'package:songlyrics/models/city_id.dart';

import '../dataproviders/cityid_provider.dart';

class CityIdRepository {
  CityIdApi _cityIdApi = CityIdApi();

  /// Fetch city-id data by the user typed city name ex-. London
  Future<City> getCityIdByCityTyped(String query) async {
    String rawResponse = await _cityIdApi.getCityIdByQuery(query);
    City city = City.fromJson(rawResponse);

    return city;
  }

  ///Fetch city-id data by using user current location-i.e Co-ordinates
  Future<City> fetchWeatherByLocation(LocationData location) async {
    String rawResponse = await _cityIdApi.getCityIdByLocation(location);

    City city = City.fromJson(rawResponse);
    return city;
  }
}
