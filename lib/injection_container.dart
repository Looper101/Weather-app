import 'package:get_it/get_it.dart';
import 'datasource/weather_provider.dart';
import 'logic/geolocationbloc/barrel.dart';
import 'logic/weatherbloc/weather_bloc.dart';
import 'package:location/location.dart';

import 'repositories/weather_repository.dart';

GetIt sl = GetIt.instance;
void init() {
//! --- Weather ---

//BLoC

  sl.registerFactory(
    () => WeatherBloc(
      location: sl(),
      weatherRepository: sl(),
    ),
  );
//Repo
  sl.registerLazySingleton<Location>(() => Location());
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepository(sl()));

  //* Api /Data source

  sl.registerLazySingleton<WeatherApi>(() => WeatherApi());

  //! --- Weather ---

//BLoC
  sl.registerFactory(
    () => GeolocationBloc(
      sl(),
    ),
  );
}
