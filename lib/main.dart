import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:songlyrics/repositories/geolocator_repository.dart';
import 'package:songlyrics/repositories/weather_repositories.dart';
import 'package:songlyrics/theme/color.dart';
import 'logic/geolocationbloc/bloc/geolocation_bloc.dart';
import 'logic/weatherbloc/bloc/weather_bloc.dart';
import 'presentation/homepage.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                GeolocationBloc(geolocatorRepository: GeolocatorRepository())),
        BlocProvider(
          create: (context) => WeatherBloc(
            weatherRepository: WeatherRepository(),
            geolocationBloc:
                GeolocationBloc(geolocatorRepository: GeolocatorRepository()),
          ),
        ),
      ],
      child: MyApp(),
    ),
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

    BlocProvider.of<GeolocationBloc>(context).add(FindLocation());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        backgroundColor: Pallete.color3,
        body: SafeArea(
          child: BlocConsumer<GeolocationBloc, GeolocationState>(
            listener: (context, state) {
              if (state is GeolocationLoadError) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        AlertDialog(title: Text(state.errorMessage)));
              }
            },
            builder: (context, state) {
              if (state is GeolocationLoaded) {
                return HomePage();
              }

              return Center(
                child: SpinKitCircle(
                  color: Pallete.errorColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
