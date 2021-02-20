import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/theme/color.dart';
import 'package:songlyrics/theme/mediaquery.dart';
import 'widgets/forecast_widget.dart';
import 'widgets/upperpart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController opacityController;

  @override
  void initState() {
    opacityController = AnimationController(
        duration: Duration(milliseconds: 1000),
        vsync: this,
        animationBehavior: AnimationBehavior.preserve);
    opacityController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DeviceOrientation deviceOrientation = DeviceOrientation();
    deviceOrientation.init(context);
    return Container(
      height: DeviceOrientation.screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocConsumer<WeatherBloc, WeatherState>(
            listener: (context, state) {
              if (state is WeatherLoadError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Pallete.errorColor,
                  content: Text(state.errorMessage),
                ));
              }
            },
            builder: (context, state) {
              if (state is WeatherLoaded) {
                opacityController.forward();
                return Expanded(
                  child: upperWeatherContainer(state),
                );
              }
              if (state is WeatherLoading) {
                return Expanded(
                  child: Center(
                      child: SpinKitChasingDots(
                    color: Pallete.errorColor,
                  )),
                );
              }
              if (state is WeatherLoadError) {
                // BlocProvider.of<WeatherBloc>(context)
                //     .add(FetchedWeatherTypedCity(query: 'London'));
              }
              return Expanded(
                child: Center(
                  child: SpinKitFadingFour(
                    duration: Duration(seconds: 1),
                    color: Pallete.textColor,
                  ),
                ),
              );
            },
          ),
          Opacity(
            opacity: opacityController.value,
            child: foreCastContainer(context),
          )
        ],
      ),
    );
  }
}

Widget searchTextFiled({Function(String) onChanged}) {
  return TextField(
    onChanged: onChanged,
  );
}
