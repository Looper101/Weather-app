import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';
import 'package:songlyrics/logic/geolocationbloc/barrel.dart';

class MockLocation extends Mock implements Location {}

void main() {
  Location location;

  setUp(() {
    location = MockLocation();
  });

  final locationData = LocationData.fromMap({"lat": 12.0, "long": 10.59});
  test('When event "FindLocation is added to Bloc"', () async {
    when(location.getLocation())
        .thenAnswer((realInvocation) async => locationData);

    final bloc = GeolocationBloc(location);

    expect(bloc.stream, contains(GeolocationLoading()));
  });
}
