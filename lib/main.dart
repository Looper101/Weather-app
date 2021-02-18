import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/presentation/homepage.dart';
import 'package:songlyrics/repositories/weather_forecast_repository.dart';
import 'package:songlyrics/repositories/weather_repositories.dart';
import 'logic/weather_forecast/bloc/forecast_bloc.dart';
import 'repositories/geolocator_repository.dart';

import 'theme/color.dart';
import 'logic/geolocationbloc/bloc/geolocation_event.dart';
import 'logic/geolocationbloc/bloc/geolocation_bloc.dart';

void main() {
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                GeolocationBloc(geolocatorRepository: GeolocatorRepository())
                  ..add(FindLocation()),
          ),
          BlocProvider(
              create: (context) => ForecastBloc(
                  geolocationBloc: BlocProvider.of<GeolocationBloc>(context),
                  weatherForecastRepository: WeatherForecastRepository())),
          BlocProvider(
              create: (context) => WeatherBloc(
                  weatherRepository: WeatherRepository(),
                  geolocationBloc: BlocProvider.of<GeolocationBloc>(context)))
        ],
        child: Scaffold(
          backgroundColor: Pallete.color2,
          body: HomePage(),
        ),
      ),
    );
  }
}
