import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/theme/color.dart';
import 'package:songlyrics/theme/mediaquery.dart';
import 'package:weather_icons/weather_icons.dart';

weatherDetails(WeatherLoaded state, BuildContext context) {
  print('rebuild check');
  return Stack(
    children: [
      Positioned(
          top: DeviceSize.height * 0.1,
          right: DeviceSize.width * 0.03,
          child: Container(
            child: CachedNetworkImage(
              placeholder: (context, string) {
                print("String unidentified $string");
                return CircularProgressIndicator(
                  strokeWidth: 10,
                );
              },
              imageUrl:
                  'https://openweathermap.org/img/wn/${state.weather.icon}@4x.png',
              fadeInDuration: Duration(milliseconds: 500),
              placeholderFadeInDuration: Duration(milliseconds: 500),
              height: 100,
              width: 100,
            ),
          )),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          countryName(state, context),
          SizedBox(height: DeviceSize.height * 0.00),
          weatherDetailsContainer(state, context),
          windDetails(state, context),
        ],
      ),
    ],
  );
}

Widget windDetails(WeatherLoaded state, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Wind',
        style: Pallete.textStyle.copyWith(
            fontSize: DeviceSize.longestSide * 0.035,
            // fontWeight: FontWeight.w100,
            color: Theme.of(context).textTheme.headline1.color),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BoxedIcon(
            WeatherIcons.barometer,
            color: Pallete.color4,
            size: DeviceSize.longestSide * 0.035,
          ),
          SizedBox(width: DeviceSize.width * 0.025),
          Text('${state.weather.windSpeed.toStringAsFixed(1)} m/s',
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(fontSize: DeviceSize.longestSide * 0.05)),
        ],
      )
    ],
  );
}

countryName(WeatherLoaded state, BuildContext context) {
  var cityName = state.weather.cityName;

  return Text(
    cityName,
    style: TextStyle(
        color: Theme.of(context).textTheme.headline1.color,
        fontSize: DeviceSize.longestSide * 0.04),
  );
}

Widget weatherDetailsContainer(WeatherLoaded state, BuildContext context) {
  var temp = state.weather.temperature;
  return Container(
    // height: DeviceOrientation.screenHeight * 0.5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: DeviceSize.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${runtimeDetector(temp)}°',
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline2.color,
                    fontSize: DeviceSize.longestSide * 0.2,
                    fontFamily: 'Bold',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}

runtimeDetector(var value) {
  if (value.runtimeType == double) {
    return (value as double).toStringAsFixed(0);
  } else {
    return (value as int).truncateToDouble().toInt();
  }
}
