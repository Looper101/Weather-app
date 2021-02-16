import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:songlyrics/repositories/geolocator_repository.dart';
import 'package:songlyrics/repositories/weather_repositories.dart';
import 'package:songlyrics/theme/color.dart';
import 'dataproviders/geolocator_provider.dart';
import 'logic/geolocationbloc/bloc/geolocation_bloc.dart';
import 'logic/weatherbloc/bloc/weather_bloc.dart';
import 'presentation/homepage.dart';

void main() {
  runApp(
    // MultiBlocProvider(
    //   providers: [

    //     // BlocProvider(
    //     //   create: (context) => WeatherBloc(
    //     //     weatherRepository: WeatherRepository(),
    //     //     geolocationBloc: BlocProvider.of<GeolocationBloc>(context),
    //     //   ),
    //     // ),
    //   ],
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
              create: (context) => GeolocationBloc(geolocator: Geolocator())
                ..add(FindLocation())),
        ],
        child: Scaffold(
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
                  return Text(state.position.location.longitude.toString());
                  // HomePage();
                }
                if (state is GeolocationInitial) {
                  return Center(child: Text('Fetching'));
                }
                if (state is GeolocationLoading) {
                  return Center(
                    child: SpinKitChasingDots(
                      color: Pallete.errorColor,
                    ),
                  );
                }
                return Center(
                  child: FlatButton(
                    onPressed: () {
                      BlocProvider.of<GeolocationBloc>(context)
                          .add(FindLocation());
                    },
                    color: Pallete.errorColor,
                    child: Text('Get Location'),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
