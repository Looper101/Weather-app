import 'package:get_it/get_it.dart';
import 'logic/geolocationbloc/barrel.dart';
import 'logic/weatherbloc/weather_bloc.dart';
import 'package:location/location.dart';

import 'repositories/weather_repository.dart';

final sl = GetIt.instance;
init() {
//! --- Weather ---

//BLoC

  sl.registerFactory(() => WeatherBloc(
        location: sl(),
        weatherRepository: sl(),
      ));
//Repo
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => WeatherRepository());

  //! --- Weather ---

//BLoC
  sl.registerFactory(() => GeolocationBloc(sl()));
}
