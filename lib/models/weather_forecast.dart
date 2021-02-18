import 'dart:convert';

class WeatherForecast {
  int cod;
  String message;
  List<Data> dataList;
  WeatherForecast({
    this.dataList,
    this.cod,
    this.message,
  });

  WeatherForecast.fromMap(Map<String, dynamic> map) {
    cod = map['cod'];
    message = map['message'];
    if (map['list'] != null) {
      dataList = List<Data>();
      List newData = map['list'];
      newData.forEach((v) {
        dataList.add(Data.fromMap(v));
      });
    }
  }

  factory WeatherForecast.fromJson(String source) =>
      WeatherForecast.fromMap(jsonDecode(source));

  ///copywith constructor creates a copy of current object with diff hashmap i guess
  WeatherForecast copyWith({
    int cod,
    String message,
    List<Data> dataList,
  }) {
    return WeatherForecast(
      cod: cod ?? this.cod,
      message: message ?? this.message,
      dataList: dataList ?? this.dataList,
    );
  }
}

class Data {
  Date dt;
  Main main;
  List<Weather> weather;
  Data({
    this.main,
    this.weather,
    this.dt,
  });

  Data.fromMap(Map<String, dynamic> map) {
    dt = map['dt'];
    main = map['main'];
    if (map['list'][1]['weather'] != null) {
      weather = List<Weather>();
//Iterate over the data from the server/API
      List newData = map['list'][1]['weather'];
      newData.forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }
  }
}

class Main {
  double temperature;
  double humidity;
  Main({this.temperature, this.humidity});

  factory Main.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Main(
      temperature: map['temperature'],
      humidity: map['humidity'],
    );
  }

  factory Main.fromJson(String source) => Main.fromMap(json.decode(source));
}

class Weather {
  int id;
  String main;
  String description;
  String icon;
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Weather(
      id: map['id'],
      main: map['main'],
      description: map['description'],
      icon: map['icon'],
    );
  }

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source));
}

class Date {
  int date;
  Date({
    this.date,
  });

  factory Date.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Date(date: map['dt']);
  }

  ///Main duty of this function is to accept the result from the server which will be
  ///in form of String --Then pass in a decoded json object to the fromMap() method
  ///The duty of the fromMap method is to return an object based on the data passed
  /// into the argument----

  factory Date.fromJson(String source) => Date.fromMap(jsonDecode(source));
}
