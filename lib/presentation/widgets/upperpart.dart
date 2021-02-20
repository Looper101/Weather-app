import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/models/weather_condition_model.dart';
import 'package:songlyrics/theme/color.dart';
import 'package:songlyrics/theme/mediaquery.dart';
import 'package:weather_icons/weather_icons.dart';

upperWeatherContainer(WeatherLoaded state) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      countryName(state),
      SizedBox(height: DeviceOrientation.screenHeight * 0.00),
      weatherDetailsContainer(state),
      windDetails(state),
      Text(
        'Forecast',
        style: TextStyle(
          color: Colors.white,
        ),
      )
    ],
  );
}

Column windDetails(WeatherLoaded state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Wind',
        style: Pallete.textStyle.copyWith(
            fontSize: 17, fontWeight: FontWeight.w100, fontFamily: 'Bold'),
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
          Text('${state.weather.windSpeed.toInt()} m/s',
              style: Pallete.textStyle.copyWith(fontSize: 17)),
        ],
      )
    ],
  );
}

countryName(WeatherLoaded state) {
  var cityName = state.weather.cityName;
  // var temp = state.weather.temperature;
  // var long = state.weather.longitude;
  // var lat = state.weather.latitude;
  var country = state.weather.countryName;
  return Column(
    children: [
      SizedBox(height: DeviceOrientation.screenHeight * 0.03),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            color: Colors.white,
          ),
          SizedBox(width: DeviceOrientation.screenWidth * 0.02),
          Text(
            '$cityName/$country',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontFamily: 'Bold',
            ),
          ),
        ],
      ),
      // Text(
      //   'Now',
      //   style: TextStyle(
      //     color: Pallete.textColor.withOpacity(0.7),
      //     fontSize: 15,
      //     fontFamily: 'Medium',
      //   ),
      // ),
    ],
  );
}

Container weatherDetailsContainer(WeatherLoaded state) {
  var cityName = state.weather.cityName;
  var temp = state.weather.temperature;
  var long = state.weather.longitude;
  var lat = state.weather.latitude;
  var country = state.weather.countryName;
  var condition = state.weather.condition;
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
              BoxedIcon(
                WeatherCondition.getIcon(condition),
                color: Pallete.textColor,
                size: DeviceOrientation.longestSide * 0.09,
              ),
              Text(
                '${temp.toInt()}°',
                style: TextStyle(
                    color: Pallete.textColor,
                    fontSize: DeviceOrientation.longestSide * 0.08,
                    fontFamily: 'Bold',
                    fontWeight: FontWeight.bold),
              ),
              Text(
                WeatherCondition.getMessage(condition),
                style: Pallete.textStyle.copyWith(fontSize: 17),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}
