import 'package:http/http.dart' as http;

class CityNameProvider {
  Future<http.Response> fetchCityName(String name) async {
    http.Response response = await http.get(
        'https://parseapi.back4app.com/classes/Continentscountriescities_City?limit=10&order=$name&keys=$name',
        headers: {
          "X-Parse-Application-Id":
              "qJhq04onHF8EbkRn2Q15jf0KbAStMWZfBb92IerQ", // This is your app's application id
          "X-Parse-REST-API-Key":
              "3TzBbaHi5pxM1PQW20Vd0jq9C12jbOdRQRKU1P20" // This is your app's REST API key
        });
    print("Response is $response");
    return response;
  }
}
