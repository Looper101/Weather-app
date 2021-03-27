import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/presentation/pages/search_page.dart';
import 'package:songlyrics/repositories/weather_repository.dart';
import 'package:songlyrics/theme/color.dart';
import 'package:songlyrics/theme/mediaquery.dart';
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

  // void testMethod() async {
  //   Weather weatherxyz = await weatherRepository.fetchWeatherByLocationRepo(
  //       longitude: -122.0, latitude: 33.0);
  //   print('The test result is : ${weatherxyz.cityName}');
  // }

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
              Navigator.pushNamed(context, SearchPage.id);
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
                    content: Text(state.errorMessage.toString()),
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
                  return Center(
                      child: Text(
                    state.errorMessage.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ));
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
