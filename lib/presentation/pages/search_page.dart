import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:songlyrics/logic/city_search_bloc/city_search_bloc.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
import 'package:songlyrics/models/city_id.dart';

class SearchPage extends StatefulWidget {
  static String id = 'searchpage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(fillColor: Colors.white, filled: true),
          controller: _textEditingController,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print(_textEditingController.text);
              BlocProvider.of<CitySearchBloc>(context)
                  .add(CitySearched(query: _textEditingController.text));
            },
          )
        ],
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitySearchBloc, CitySearchState>(
      builder: (context, state) {
        if (state is CitySearchLoading) {
          return Center(
            child: Loading(
              color: Colors.red,
              indicator: BallPulseIndicator(),
            ),
          );
        }
        if (state is CitySearchLoaded) {
          var _itemCount = state.city.cities.length;

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

        return Center(child: Text('Enter city name'));
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
