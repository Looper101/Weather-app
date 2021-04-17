import 'dart:convert';

class Weather {
  final String cityName;
  final dynamic temperature;
  final dynamic windSpeed;
  final String icon;

  Weather({this.cityName, this.temperature, this.windSpeed, this.icon});

  factory Weather.fromRawJson(String source) =>
      Weather.fromJson(jsonDecode(source));

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'],
        windSpeed: json['wind']['speed'],
        icon: json['weather'][0]['icon']);
  }

  Weather copyWith({Weather weather
      // String cityName,
      // dynamic temperature,
      // dynamic windSpeed,
      // String icon,
      }) {
    return Weather(
      cityName: weather.cityName ?? this.cityName,
      temperature: weather.temperature ?? this.temperature,
      windSpeed: weather.windSpeed ?? this.windSpeed,
      icon: weather.icon ?? this.icon,
    );
  }
}
