import 'dart:convert';

class Weather {
  final String cityName;
  final String sunrise;
  final String sunset;
  final List<ConsolidatedWeather> consolidatedWeather;

  Weather({
    this.cityName,
    this.sunrise,
    this.sunset,
    this.consolidatedWeather,
  });

  factory Weather.fromRawJson(String source) =>
      Weather.fromJson(jsonDecode(source));

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['title'],
        sunrise: json['sun_rise'],
        sunset: json['sun_set'],
        consolidatedWeather: List.from(json['consolidated_weather'])
            .map((e) => ConsolidatedWeather.fromJson(e))
            .toList());
  }
}

class ConsolidatedWeather {
  final int id;
  final String weatherStateName;
  final String weatherDirectionCompass;
  final String applicableDate;
  final double minTemp;
  final double maxTemp;
  final double temp;
  final double windSpeed;
  final double windDirection;

  final int humididty;
  final double visibility;
  final int predictability;
  ConsolidatedWeather({
    this.id,
    this.weatherStateName,
    this.weatherDirectionCompass,
    this.applicableDate,
    this.minTemp,
    this.maxTemp,
    this.temp,
    this.windSpeed,
    this.windDirection,
    this.humididty,
    this.visibility,
    this.predictability,
  });

  factory ConsolidatedWeather.fromRawJson(String source) =>
      ConsolidatedWeather.fromJson(jsonDecode(source));
  factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) {
    return ConsolidatedWeather(
      id: json['id'],
      weatherStateName: json['weather_state_name'],
      weatherDirectionCompass: json['weather_state_abbr'],
      applicableDate: json['applicable_date'],
      minTemp: json['min_temp'],
      maxTemp: json['max_temp'],
      temp: json['the_temp'],
      windSpeed: json['wind_speed'],
      windDirection: json['wind_direction'],
      humididty: json['humidity'],
      visibility: json['visibility'],
      predictability: json['predictability'],
    );
  }
}
