import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
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

  FocusNode _focusNode = FocusNode();
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
          focusNode: _focusNode,
          autofocus: true,
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
                _focusNode.unfocus();

                BlocProvider.of<WeatherBloc>(context)
                    .add(CitySearchQuery(query: _textEditingController.text));
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
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is CitySearched) {
          Navigator.pop(context);
        }
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
//
// class ResultItem extends StatelessWidget {
//   const ResultItem(
//     this.cityId,
//   );
//   final CityId cityId;
//   @override
//   Widget build(BuildContext context) {
//     var separatedString = separateString(cityId.coordinate);
//     var long = separatedString[0];
//     var lat = separatedString[1];
//
//     return ListTile(
//       tileColor: Colors.white,
//       subtitle: Text('Long:$long Lat:$lat'),
//       title: Text(cityId.cityName.toString()),
//       onTap: () {
//         // BlocProvider.of<CitySearchBloc>(context)
//         //     .add(CitySelected(cityId: cityId));
//         // Navigator.pop(context);
//       },
//     );
//   }
// }
//
// List<String> separateString(String str) {
//   List<String> splittedString = str.split(',');
//
//   return splittedString;
// }
