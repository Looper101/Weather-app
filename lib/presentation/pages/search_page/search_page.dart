import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  GlobalKey _scaffoldKey = GlobalKey();

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
    _textEditingController
      ..clear()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: TextField(
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(fontSize: DeviceSize.longestSide * 0.03),
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
                    .add(CitySearching(_textEditingController.text));
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
        if (state is CityLoaded) {
          Navigator.pop(context);
        }

        if (state is CitySearchError) {}
      },
      builder: (context, state) {
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
        // BlocProvider.of<CitySearchBloc>(context)
        //     .add(CitySelected(cityId: cityId));
        // Navigator.pop(context);
      },
    );
  }
}

List<String> separateString(String str) {
  List<String> splittedString = str.split(',');

  return splittedString;
}
