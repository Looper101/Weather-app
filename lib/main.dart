import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/presentation/homepage.dart';
import 'package:songlyrics/repositories/city_name_repository.dart';
import 'package:songlyrics/repositories/weather_forecast_repository.dart';
import 'package:songlyrics/repositories/weather_repositories.dart';
import 'logic/city_search/city_search_bloc.dart';
import 'logic/weather_forecast/bloc/forecast_bloc.dart';
import 'repositories/geolocator_repository.dart';

void main() {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forecaster',
      theme: ThemeData(primarySwatch: Colors.red),
      home: MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (context) =>
          //       GeolocationBloc(geolocatorRepository: GeolocatorRepository())
          //         ..add(FindLocation()),
          // ),

          BlocProvider(
              create: (context) => ForecastBloc(
                  // geolocationBloc: BlocProvider.of<GeolocationBloc>(context),
                  weatherForecastRepository: WeatherForecastRepository())
                ..add(AppStarted())),
          BlocProvider(
              create: (context) => WeatherBloc(
                    weatherRepository: WeatherRepository(),
                    geolocatorRepository: GeolocatorRepository(),
                  )..add(FetchWeatherByLocation())),

          BlocProvider(create: (context) => CitySearchBloc(CityNameRepo()))
        ],
        child: HomePage(),
      ),
    );
  }
}
