import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/presentation/homepage.dart';
import 'package:songlyrics/presentation/pages/search_page.dart';
import 'package:songlyrics/repositories/cityId_repository.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => WeatherBloc(
                  weatherRepository: CityIdRepository(),
                  geolocatorRepository: GeolocatorRepository(),
                )..add(FetchWeatherByLocation())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Forecaster',
        theme: ThemeData(primarySwatch: Colors.red),
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => HomePage(),
          SearchPage.id: (context) => SearchPage(),
        },
      ),
    );
  }
}
