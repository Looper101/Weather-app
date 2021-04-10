import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:songlyrics/logic/city_search_bloc/city_search_bloc.dart';
import 'package:songlyrics/models/city_id.dart';
import 'package:songlyrics/theme/mediaquery.dart';

class SearchPage extends StatefulWidget {
  static String id = 'searchpage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textEditingController = TextEditingController();

  bool isEmpty = false;

  void checkValueLength() {
    isEmpty = _textEditingController.text.length > 0;
    print(isEmpty);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<CitySearchBloc>(context).dispose();
    _textEditingController
      ..clear()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: TextField(
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(fontSize: DeviceOrientation.longestSide * 0.03),
          decoration: InputDecoration(fillColor: Colors.white, filled: true),
          controller: _textEditingController,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (_textEditingController.text.length > 0) {
                print(_textEditingController.text);
                BlocProvider.of<CitySearchBloc>(context)
                    .add(CitySearched(query: _textEditingController.text));
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                          'Searchfield can\'t be empty',
                          style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: DeviceOrientation.longestSide * 0.02),
                        ),
                      );
                    });
              }
            },
          )
        ],
      ),
      body: Body(
        controller: _textEditingController,
        context: context,
      ),
    );
  }
}

class Body extends StatelessWidget {
  final TextEditingController controller;
  final BuildContext context;

  const Body({Key key, this.controller, this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CitySearchBloc, CitySearchState>(
      listener: (context, state) {
        if (state is CitySearchLoaded) {
          if (state.city.cities.length == 0) {
            BlocProvider.of<CitySearchBloc>(context)
                .add(CityInvalidTyped(cityTyped: '${controller.text}'));
          }
        }

        if (state is CitySearchError) {}
      },
      builder: (context, state) {
        if (state is CitySearchLoading) {
          return Center(
            child: Loading(
              color: Theme.of(context).scaffoldBackgroundColor,
              indicator: BallPulseIndicator(),
            ),
          );
        }
        if (state is CitySearchLoaded) {
          var _itemCount = state.city.cities.length;
          if (_itemCount != 0) {
            return ListView.builder(
                itemCount: _itemCount,
                itemBuilder: (context, index) {
                  CityId _city = state.city.cities[index];

                  return state.city.cities.isEmpty != null
                      ? ResultItem(_city)
                      : Center(
                          child: Text('No city found'),
                        );
                });
          }
        }
        if (state is CitySearchError) {
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //     content: Text('${state.errorMessage} not a valid city name')));

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('sfksdfsgddjh'),
                );
              });
        }
        return Center(
          child: Text(
            'Enter city name',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}

class ResultItem extends StatelessWidget {
  const ResultItem(
    this.cityId,
  );
  final CityId cityId;
  @override
  Widget build(BuildContext context) {
    var separatedString = separateString(cityId.coordinate);
    var long = separatedString[0];
    var lat = separatedString[1];

    return ListTile(
      tileColor: Colors.white,
      subtitle: Text('Long:$long Lat:$lat'),
      title: Text(cityId.cityName.toString()),
      onTap: () {
        BlocProvider.of<CitySearchBloc>(context)
            .add(CitySelected(cityId: cityId));
        Navigator.pop(context);
      },
    );
  }
}

List<String> separateString(String str) {
  List<String> splittedString = str.split(',');

  return splittedString;
}
