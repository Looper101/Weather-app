import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_theme.dart';
import 'injection_container.dart';

import 'presentation/pages/home_page/homepage.dart';
import 'presentation/pages/search_page/search_page.dart';
import 'weather_observer.dart';

import 'logic/weatherbloc/barrel.dart';

void main() {
  Bloc.observer = WeatherObserver();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.grey[500]));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => sl<WeatherBloc>()
              ..add(
                FetchWeatherByLocation(),
              )),
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
