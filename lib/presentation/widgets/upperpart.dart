import 'package:flutter/material.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/theme/color.dart';
import 'package:songlyrics/theme/mediaquery.dart';
import 'package:weather_icons/weather_icons.dart';

upperWeatherContainer(WeatherLoaded state, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      countryName(state, context),
      SizedBox(height: DeviceOrientation.screenHeight * 0.00),
      weatherDetailsContainer(state, context),
      windDetails(state, context),
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
            fontSize: DeviceOrientation.longestSide * 0.035,
            // fontWeight: FontWeight.w100,
            color: Theme.of(context).textTheme.headline1.color),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BoxedIcon(
            WeatherIcons.barometer,
            color: Pallete.color4,
            size: DeviceOrientation.longestSide * 0.035,
          ),
          SizedBox(width: DeviceOrientation.screenWidth * 0.025),
          Text('${state.weather.consolidatedWeather[0].windSpeed.toInt()} m/s',
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(fontSize: DeviceOrientation.longestSide * 0.05)),
        ],
      )
    ],
  );
}

countryName(WeatherLoaded state, BuildContext context) {
  // var cityName = state.weather.cityName;
  // // var temp = state.weather.temperature;
  // // var long = state.weather.longitude;
  // // var lat = state.weather.latitude;
  // var country = state.weather.countryName;
  // return Column(
  //   children: [
  //     SizedBox(height: DeviceOrientation.screenHeight * 0.03),
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Icon(
  //           Icons.location_on,
  //           color: Colors.white,
  //         ),
  //         SizedBox(width: DeviceOrientation.screenWidth * 0.02),
  //         Text(
  //           '$cityName/$country',
  //           style: TextStyle(
  //             color: Colors.red,
  //             fontSize: 20,
  //             fontFamily: 'Bold',
  //           ),
  //         ),
  //       ],
  //     ),
  //     // Text(
  //     //   'Now',
  //     //   style: TextStyle(
  //     //     color: Pallete.textColor.withOpacity(0.7),
  //     //     fontSize: 15,
  //     //     fontFamily: 'Medium',
  //     //   ),
  //     // ),
  //   ],
  // );

  return Text(
    state.weather.cityName,
    style: TextStyle(
        color: Theme.of(context).textTheme.headline1.color,
        fontSize: DeviceOrientation.longestSide * 0.04),
  );
}

Widget weatherDetailsContainer(WeatherLoaded state, BuildContext context) {
  var cityName = state.weather.cityName;
  var temp = state.weather.consolidatedWeather[0].temp;
  var stateName = state.weather.consolidatedWeather[0].weatherStateName;
  return Container(
    // height: DeviceOrientation.screenHeight * 0.5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: DeviceOrientation.screenHeight * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // BoxedIcon(
              //     // WeatherCondition.getIcon(condition),
              //     // color: Pallete.textColor,
              //     // size: DeviceOrientation.longestSide * 0.09,
              //     ),
              Text(
                '${temp.toInt()}°',
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline2.color,
                    fontSize: DeviceOrientation.longestSide * 0.2,
                    fontFamily: 'Bold',
                    fontWeight: FontWeight.bold),
              ),
              // Text(
              //   WeatherCondition.getMessage(condition),
              //   style: Pallete.textStyle.copyWith(fontSize: 17),
              // ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );

  return Text(
    'weather container goes here',
    style: TextStyle(color: Colors.white),
  );
}

Widget searchTextFiled({Function(String) onChanged}) {
  return Container(
    color: Colors.red,
    child: TextField(
      decoration: InputDecoration(fillColor: Pallete.color4),
      onChanged: onChanged,
    ),
  );
}
