import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/presentation/pages/home_page/widgets/weather_details.dart';
import 'package:songlyrics/presentation/pages/home_page/widgets/weather_details_shimmer_effect.dart';
import 'package:songlyrics/repositories/weather_repository.dart';
import 'package:songlyrics/theme/mediaquery.dart';

import '../search_page/search_page.dart';

class HomePage extends StatefulWidget {
  static String id = 'homepage';

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

  WeatherRepository weatherRepository = WeatherRepository();

  @override
  Widget build(BuildContext context) {
    DeviceSize deviceOrientation = DeviceSize();
    deviceOrientation.init(context);
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: _buildAppBar(),
      body: Container(
        height: DeviceSize.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.grey[400],
            Colors.grey[200],
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocConsumer<WeatherBloc, WeatherState>(
              listener: (context, state) {
                if (state is WeatherLoadError) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).errorColor,
                        content: Text('Check your connection'),
                      ),
                    );
                }
              },
              builder: (context, state) {
                if (state is WeatherLoaded) {
                  // opacityController.forward();
                  return Expanded(
                    child: weatherDetails(state, context),
                  );
                }
                if (state is WeatherLoading) {
                  return Expanded(
                    child: weatherDetailsLoadingFX(),
                  );
                }

                return _buildErrorMessage();
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildDrawer() {
    return Drawer(
      child: Container(
        color: Theme.of(context).buttonColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerHeader(
                padding: EdgeInsets.only(top: 20),
                child: Text('P-O-I-N-Q'),
              ),
              SizedBox(),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.blueGrey[200],
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: DeviceSize.height * 0.35,
                          color: Colors.white,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      children: [
                                        Text('Lawal Opeyemi Noah'),
                                        Text('Software Developer'),
                                      ],
                                    )
                                  ],
                                ),

                                ///////
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text('Links'),
                                    Expanded(
                                      child: Container(
                                        height: 3,
                                        width: double.infinity,
                                        color: Colors.black45,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Text('About Developer',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        fontSize: DeviceSize.longestSide * 0.03,
                        fontWeight: FontWeight.w100)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: Size(0.0, 56.0),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoaded) {
            return AppBar(
              backgroundColor: Colors.grey[500],
              title: Text(
                'Poinq',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white70),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, SearchPage.id);
                  },
                )
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  _buildErrorMessage() {
    return Expanded(
      child: Container(
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
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              onPressed: () => BlocProvider.of<WeatherBloc>(context)
                  .add(FetchWeatherByLocation()),
            ),
          ],
        ),
      ),
    );
  }
}
