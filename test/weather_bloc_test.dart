import 'package:http/http.dart';

void fetc() async {
  Response response = await get('url');
  response.reasonPhrase;
}
