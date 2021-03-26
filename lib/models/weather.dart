// import 'dart:convert';

// ///Model for fetched weather data from openweather api

// //TODO: Restructure this model for the metaweather api reponse
// class Weather {
//   final num temperature;
//   final double latitude;
//   final double longitude;
//   final String countryName;
//   final String cityName;
//   final int condition;
//   final double windSpeed;
//   Weather(
//       {this.temperature,
//       this.latitude,
//       this.longitude,
//       this.countryName,
//       this.cityName,
//       this.condition,
//       this.windSpeed});

//   // Weather copyWith({
//   //   double temperature,
//   //   double latitude,
//   //   double longitude,
//   //   String countryName,
//   //   String cityName,
//   // }) {
//   //   return Weather(
//   //     temperature: temperature ?? this.temperature,
//   //     latitude: latitude ?? this.latitude,
//   //     longitude: longitude ?? this.longitude,
//   //     countryName: countryName ?? this.countryName,
//   //     cityName: cityName ?? this.cityName,
//   //   );
//   // }

//   // Map<String, dynamic> toMap() {
//   //   return {
//   //     'temperature': temperature,
//   //     'latitude': latitude,
//   //     'longitude': longitude,
//   //     'countryName': countryName,
//   //     'cityName': cityName,
//   //   };
//   // }

//   factory Weather.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Weather(
//       temperature: map['main']['temp'],
//       latitude: map['coord']['lat'],
//       longitude: map['coord']['lon'],
//       countryName: map['sys']['country'],
//       cityName: map['name'],
//       condition: map['cod'],
//       windSpeed: map['wind']['speed'],
//     );
//   }

//   factory Weather.fromJson(String source) =>
//       Weather.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Weather(temperature: $temperature, latitude: $latitude, longitude: $longitude, countryName: $countryName, cityName: $cityName,condition:$condition,windSpeed:$windSpeed)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is Weather &&
//         o.temperature == temperature &&
//         o.latitude == latitude &&
//         o.longitude == longitude &&
//         o.countryName == countryName &&
//         o.cityName == cityName &&
//         o.windSpeed == windSpeed &&
//         o.condition == condition;
//   }

//   @override
//   int get hashCode {
//     return temperature.hashCode ^
//         latitude.hashCode ^
//         longitude.hashCode ^
//         countryName.hashCode ^
//         cityName.hashCode ^
//         windSpeed.hashCode ^
//         condition.hashCode;
//   }
// }

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
            .map((e) => ConsolidatedWeather.fromJson(e)));
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
  final int airPressure;
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
    this.airPressure,
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
      airPressure: json['air_pressure'],
      humididty: json['humidity'],
      visibility: json['visibility'],
      predictability: json['predictability'],
    );
  }
}
