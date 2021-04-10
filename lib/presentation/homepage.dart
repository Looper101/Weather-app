import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/repositories/weather_repository.dart';
import 'package:songlyrics/theme/mediaquery.dart';

import 'pages/search_page.dart';
import 'widgets/upperpart.dart';

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
    DeviceOrientation deviceOrientation = DeviceOrientation();
    deviceOrientation.init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0.0, 56.0),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoaded) {
              return AppBar(
                title: Text(
                  'Forecaster',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.blueGrey),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
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
      ),
      body: Container(
        height: DeviceOrientation.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocConsumer<WeatherBloc, WeatherState>(
              listener: (context, state) {
                if (state is WeatherLoadError) {
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   backgroundColor: Theme.of(context).backgroundColor,
                  //   content: Text('Check your connection'),
                  // ));

                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Not connected to internet',
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Check your internet settings'),
                            ],
                          ),
                          actions: [
                            IconButton(
                              icon: Icon(Icons.refresh_outlined),
                              onPressed: () =>
                                  BlocProvider.of<WeatherBloc>(context)
                                      .add(FetchWeatherByLocation()),
                            )
                          ],
                        );
                      });
                }
              },
              builder: (context, state) {
                if (state is WeatherLoaded) {
                  opacityController.forward();
                  return Expanded(
                    child: upperWeatherContainer(state, context),
                  );
                }
                if (state is WeatherLoading) {
                  return Expanded(
                    child: Center(
                        child: SpinKitChasingDots(
                      color: Theme.of(context).accentColor,
                    )),
                  );
                }

                return Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Failed to connect",
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(height: DeviceOrientation.screenHeight * 0.03),
                        RawMaterialButton(
                          constraints:
                              BoxConstraints.tightFor(width: 140, height: 50),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomSearchDelegate extends SearchDelegate {
//   set query(String value) {
//     assert(query != null);
//   }

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//         icon: Icon(Icons.arrow_back_ios),
//         onPressed: () => Navigator.pop(context));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return BlocConsumer<CitySearchBloc, CitySearchState>(
//         listener: (context, state) {
//       if (state is CitySearchError) {
//         return Scaffold.of(context)
//             .showSnackBar(SnackBar(content: Text(state.errorMessage)));
//       }
//     }, builder: (context, state) {
//       if (state is CitySearchInitial) {
//         return Center(
//           child: Text('Enter city Name above'),
//         );
//       }
//       if (state is CitySearchLoading) {
//         return Loading(
//           indicator: BallPulseIndicator(),
//           color: Pallete.color4,
//         );
//       }

//       if (state is CitySearchLoaded) {
//         return ListView.builder(itemBuilder: (context, index) {
//           return Card(child: Text(state.city.results[index].cityName));
//         });
//       }

//       return Container();
//     });
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Text(query);
//   }
// }
