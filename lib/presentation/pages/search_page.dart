import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
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
              BlocProvider.of<WeatherBloc>(context).add(
                  FetchedWeatherTypedCity(query: _textEditingController.text));
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
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadError) {
          return AlertDialog(
            title: Text(state.errorMessage),
          );
        }
        if (state is WeatherLoaded) {
          var _itemCount = state.city.cities.length;

          return ListView.builder(
              itemCount: _itemCount,
              itemBuilder: (context, index) {
                CityId item = state.city.cities[index];
                return ResultItem(item);
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
    return Text(cityId.cityName);
  }
}

Widget resultItem() {
  return ListTile(
    leading: Text('cityName'),
  );
}
