import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';
import 'package:songlyrics/logic/weatherbloc/barrel.dart';
import 'package:songlyrics/repositories/weather_repository.dart';

class MocKWeatherRepository extends Mock implements WeatherRepository {}

class MockLocation extends Mock implements Location {}

void main() {
  MocKWeatherRepository mockWeatherRepository;
  MockLocation location;

  setUp(() {
    mockWeatherRepository = MocKWeatherRepository();
    location = Location();
  });

  group('tests', () {
    test('fect city by name', () {
      when(mockWeatherRepository.fetchWeatherByCityTyped(any))
          .thenAnswer((_) => null);

      final bloc = WeatherBloc(
        location: location,
        weatherRepository: mockWeatherRepository,
      );

      bloc.add(CitySearchQuery(query: any));

      //assert

      expect(bloc.stream, isNotNull);
    });
  });
}
