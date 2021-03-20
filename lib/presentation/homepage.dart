import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:songlyrics/logic/city_search/city_search_bloc.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/theme/color.dart';
import 'package:songlyrics/theme/mediaquery.dart';
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
    return Scaffold(
      backgroundColor: Pallete.color2,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          )
        ],
      ),
      body: Container(
        height: DeviceOrientation.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocConsumer<WeatherBloc, WeatherState>(
              listener: (context, state) {
                if (state is WeatherLoadError) {
                  Scaffold.of(context).showSnackBar(SnackBar(
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
                  return Center(child: Text(state.errorMessage));
                }
                return Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: RawMaterialButton(
                        constraints:
                            BoxConstraints.tightFor(width: 140, height: 70),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        fillColor: Pallete.errorColor,
                        child: Text('Retry'),
                        onPressed: () {}),
                  ),
                );
              },
            ),
            // Opacity(
            //   opacity: opacityController.value,
            //   child: foreCastContainer(context),
            // )
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context));
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocConsumer<CitySearchBloc, CitySearchState>(
        listener: (context, state) {
      if (state is CitySearchError) {
        return Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(state.errorMessage)));
      }
    }, builder: (context, state) {
      if (state is CitySearchInitial) {
        return Center(
          child: Text('Enter city Name above'),
        );
      }
      if (state is CitySearchLoading) {
        return Loading(
          indicator: BallPulseIndicator(),
          color: Pallete.color4,
        );
      }

      if (state is CitySearchLoaded) {
        return ListView.builder(itemBuilder: (context, index) {
          return Card(child: Text(state.city.results[index].cityName));
        });
      }

      return Container();
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text(query);
  }
}
