import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songlyrics/custom_theme.dart';
import 'package:songlyrics/logic/city_search_bloc/city_search_bloc.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/repositories/cityId_repository.dart';
import 'package:songlyrics/repositories/weather_repository.dart';
import 'package:songlyrics/weather_observer.dart';

import 'file:///C:/Users/Ope/AndroidStudioProjects/Weather-app-1/lib/presentation/pages/home_page/homepage.dart';
import 'file:///C:/Users/Ope/AndroidStudioProjects/Weather-app-1/lib/presentation/pages/search_page/search_page.dart';

import 'repositories/geolocator_repository.dart';

void main() {
  Bloc.observer = WeatherObserver();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

// child: MyApp()
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.grey[500]));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CitySearchBloc(),
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
        title: 'Poinq',
        theme: lightTheme,
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => HomePage(),
          SearchPage.id: (context) => SearchPage(),
        },
      ),
    );
  }
}
