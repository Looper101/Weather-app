import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songlyrics/custom_theme.dart';
import 'package:songlyrics/logic/city_search_bloc/city_search_bloc.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/presentation/homepage.dart';
import 'package:songlyrics/presentation/pages/search_page.dart';
import 'package:songlyrics/repositories/cityId_repository.dart';
import 'package:songlyrics/repositories/weather_repository.dart';
import 'package:songlyrics/weather_observer.dart';

import 'repositories/geolocator_repository.dart';

void main() {
  Bloc.observer = WeatherObserver();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

// child: MyApp()
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CityIdRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CitySearchBloc(
                RepositoryProvider.of<CityIdRepository>(context)),
          ),
          BlocProvider(
              create: (context) => WeatherBloc(
                  cityIdRepository:
                      RepositoryProvider.of<CityIdRepository>(context),
                  citySearchBloc: context.read<CitySearchBloc>(),
                  geolocatorRepository: GeolocatorRepository(),
                  weatherRepository: WeatherRepository())
                ..add(FetchWeatherByLocation())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Forecaster',
          theme: lightTheme,
          initialRoute: HomePage.id,
          routes: {
            HomePage.id: (context) => HomePage(),
            SearchPage.id: (context) => SearchPage(),
          },
        ),
      ),
    );
  }
}

//
// MultiBlocProvider(
// providers: [
// BlocProvider(
// create: (context) => WeatherBloc(
// citySearchBloc: CitySearchBloc(
// RepositoryProvider.of<CityIdRepository>(context)),
// geolocatorRepository: GeolocatorRepository(),
// )..add(FetchWeatherByLocation())),
// ],
// child: MaterialApp(
// debugShowCheckedModeBanner: false,
// title: 'Forecaster',
// theme: ThemeData(primarySwatch: Colors.red),
// initialRoute: HomePage.id,
// routes: {
// HomePage.id: (context) => HomePage(),
// SearchPage.id: (context) => SearchPage(),
// },
// ),
// ),
