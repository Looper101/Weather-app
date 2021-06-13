import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/presentation/pages/home_page/widgets/weather_details.dart';
import 'package:songlyrics/presentation/pages/home_page/widgets/weather_details_shimmer_effect.dart';
import 'package:songlyrics/theme/mediaquery.dart';

import 'widgets/widgets.dart';

class HomePage extends StatefulWidget {
  static String id = 'homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  final _animDuration = Duration(seconds: 2);
  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: _animDuration);
    animation = Tween<double>(begin: 0, end: 200).animate(controller);

    controller.addStatusListener((status) async {
      await controlAnimation(status);
    });
  }

  Future<void> controlAnimation(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      //delay/wait for 3 seconds
      await Future.delayed(_animDuration).then((value) => controller.reverse());
      //then retract
      //and at half way fade out

      //! Multiple animation to be  binded together
    }
  }

  @override
  Widget build(BuildContext context) {
    DeviceSize deviceOrientation = DeviceSize();
    deviceOrientation.init(context);

    var _bloc = BlocProvider.of<WeatherBloc>(context);
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: buildAppBar(context),
      body: Container(
        height: DeviceSize.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.grey[400],
            Colors.grey[100],
          ],
        )),
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoadError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.black,
                    content: AutoSizeText(
                      '${state.errorMessage}',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is WeatherLoading) {
              return weatherDetailsLoadingFX();
            }
            if (state is WeatherLoaded) {
              return weatherDetails(state, context);
            }

            if (state is WeatherLoadCityException) {
              return ShowOnError(bloc: _bloc);
            }

            return _buildErrorMessage(_bloc);
          },
        ),
      ),
    );
  }

  _buildErrorMessage(WeatherBloc bloc) {
    return Stack(
      children: [
        Positioned(
          top: DeviceSize.height * 0.05,
          left: DeviceSize.width * 0.05,
          child: Container(
            // height: DeviceSize.height * 0.09,
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
        Positioned(
          top: DeviceSize.height * 0.07,
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
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/wifi_off1.png'),
                color: Colors.black26,
                height: DeviceSize.height * 0.07,
                width: DeviceSize.width * 0.2,
                fit: BoxFit.contain,
              ),
              SizedBox(height: DeviceSize.height * 0.07),
              Text(
                "Failed to connect",
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: DeviceSize.height * 0.03),
              RawMaterialButton(
                constraints: BoxConstraints.tightFor(width: 140, height: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                fillColor: Theme.of(context).backgroundColor,
                child: Text(
                  'Retry',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => bloc.add(FetchWeatherByLocation()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
              // height: DeviceSize.height * 0.09,
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
