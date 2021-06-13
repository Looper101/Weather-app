import 'package:flutter/material.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/theme/mediaquery.dart';

class ShowOnError extends StatelessWidget {
  const ShowOnError({
    Key key,
    @required WeatherBloc bloc,
  })  : _bloc = bloc,
        super(key: key);

  final WeatherBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: DeviceSize.height * 0.01,
          left: DeviceSize.width * 0.05,
          child: GestureDetector(
            onTap: () => _bloc.add(FetchWeatherByLocation()),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(DeviceSize.longestSide * 0.02),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.navigation_sharp,
                  size: DeviceSize.longestSide * 0.03,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: DeviceSize.height * 0.03,
          left: DeviceSize.width * 0.16,
          child: Container(
            height: DeviceSize.height * 0.03,
            padding: EdgeInsets.symmetric(horizontal: DeviceSize.width * 0.02),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Text(
              'Fetch Weather for my Location',
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Bold'),
            ),
          ),
        ),
        Center(
          child: Text(
            'City can\'t be found !',
            style: TextStyle(
                fontFamily: 'Bold', fontSize: DeviceSize.longestSide * 0.025),
          ),
        ),
      ],
    );
  }
}
