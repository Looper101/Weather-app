import 'package:location/location.dart';
import 'package:songlyrics/datasource/city_api.dart';
import 'package:songlyrics/models/city_id.dart';

class CityIdRepository {
  CityApi _cityIdApi = CityApi();

  /// Fetch city-id data by the user typed city name ex-. London
  Future<City> getCityIdByCityTyped(String query) async {
    String rawResponse = await _cityIdApi.getCityIdByQuery(query);
    City city = City.fromJson(rawResponse);

    return city;
  }

  ///Fetch cityId by User Location
  Future<City> fetchCityIdByLocation(LocationData location) async {
    String rawResponse = await _cityIdApi.getCityIdByLocation(location);

    City city = City.fromJson(rawResponse);
    return city;
  }
}
