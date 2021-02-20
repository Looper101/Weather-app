import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:songlyrics/models/weather_forecast.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:songlyrics/logic/weather_forecast/bloc/forecast_bloc.dart';
import 'package:songlyrics/models/weather_condition_model.dart';
import 'package:songlyrics/theme/color.dart';
import 'package:songlyrics/theme/mediaquery.dart';

foreCastContainer(BuildContext context) {
  return Container(
      color: Pallete.color2,
      height: DeviceOrientation.screenHeight * 0.25,
      child:
          BlocBuilder<ForecastBloc, ForecastState>(builder: (context, state) {
        if (state is ForecastInitial) {
          return Center(
            child: SpinKitHourGlass(
              color: Pallete.color2,
            ),
          );
        }

        if (state is ForeCastLoadError) {
          return Center(
            child: Text(state.message,
                style: TextStyle(color: Colors.white, fontSize: 25)),
          );
        }
        if (state is ForecastLoaded) {
          return ListView.builder(
            itemCount: state.weatherForecast.list.length,
            itemBuilder: (context, _) {
              var weatherForecast = state.weatherForecast.list[_];
              var date = state.weatherForecast.list[_].dtTxt;
              var condition = state.weatherForecast.list[_].weather.first;
              return ForecastItem(
                date: date,
                cod: condition.id,
                weatherForecast: weatherForecast,
              );
            },
          );
        }

        return Container();
      }));
}

class ForecastItem extends StatelessWidget {
  const ForecastItem({
    Key key,
    @required this.date,
    this.cod,
    this.weatherForecast,
  }) : super(key: key);

  final DateTime date;
  final int cod;
  final ListElement weatherForecast;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: DeviceOrientation.screenHeight * 0.06,
            width: DeviceOrientation.screenWidth * 0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: BoxedIcon(WeatherCondition.getIcon(cod)),
          ),
          Text(
            '${weekdayParse(date.weekday)}',
            // -${monthParse(date.month)}-${date.year}',
            style:
                Pallete.textStyle.copyWith(fontSize: 15, color: Colors.black),
          ),
          BoxedIcon(WeatherCondition.getIcon(cod)),
          Text(
            '${weatherForecast.main.temp.toInt()}°°',
            style: Pallete.textStyle.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

String stringParsing(String value) {
  DateTime date = DateTime.parse(value);
  // var formattedDate = formatDate(date, [yyyy, '/', mm, '/', dd]);
  String finalOutput = '${weekdayParse(date.weekday)}';
  print(finalOutput);
  return finalOutput;
}

String weekdayParse(int value) {
  print(value);
  switch (value) {
    case 7:
      return 'Sun';
      break;
    case 1:
      return 'Mon';
      break;
    case 2:
      return 'Tue';
      break;
    case 3:
      return 'Wed';
      break;
    case 4:
      return 'Thur';
      break;
    case 5:
      return 'Fri';
      break;
    case 6:
      return 'Sat';
      break;
    default:
      return 'null';
  }
}

String monthParse(int value) {
  switch (value) {
    case 1:
      return 'Jan';
      break;

    case 2:
      return 'Feb';
      break;
    case 3:
      return 'Mar';
      break;

    case 4:
      return 'Apr';
      break;
    case 5:
      return 'May';
      break;

    case 6:
      return 'June';
      break;
    case 7:
      return 'July';
      break;

    case 8:
      return 'Aug';
      break;
    case 9:
      return 'Spt';
      break;

    case 10:
      return 'Oct';
      break;
    case 11:
      return 'Nov';
      break;

    case 12:
      return 'Dec';
      break;
    default:
      return '';
  }
}
