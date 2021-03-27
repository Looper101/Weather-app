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
          return Loading(
            indicator: BallPulseIndicator(),
          );
        }
        if (state is CitySearchLoaded) {
          var _itemCount = state.city.cities.length;

          return ListView.builder(
              itemCount: _itemCount,
              itemBuilder: (context, index) {
                CityId _city = state.city.cities[index];

                return ResultItem(_city);
              });
        }

        if (state is WeatherLoading) {
          return Center(
            child: Loading(
              color: Colors.black,
              indicator: BallPulseIndicator(),
            ),
          );
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
    return ListTile(
      title: Text(cityId.cityName),
      subtitle: Text(cityId.coordinate),
      onTap: () {
        //TODO:Add a (CityPicked) event to the citySearch Bloc
      },
    );
  }
}
