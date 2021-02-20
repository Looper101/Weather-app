import 'dart:convert';

class Weather {
  final num temperature;
  final double latitude;
  final double longitude;
  final String countryName;
  final String cityName;
  final int condition;
  final double windSpeed;
  Weather(
      {this.temperature,
      this.latitude,
      this.longitude,
      this.countryName,
      this.cityName,
      this.condition,
      this.windSpeed});

  // Weather copyWith({
  //   double temperature,
  //   double latitude,
  //   double longitude,
  //   String countryName,
  //   String cityName,
  // }) {
  //   return Weather(
  //     temperature: temperature ?? this.temperature,
  //     latitude: latitude ?? this.latitude,
  //     longitude: longitude ?? this.longitude,
  //     countryName: countryName ?? this.countryName,
  //     cityName: cityName ?? this.cityName,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'temperature': temperature,
  //     'latitude': latitude,
  //     'longitude': longitude,
  //     'countryName': countryName,
  //     'cityName': cityName,
  //   };
  // }

  factory Weather.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Weather(
      temperature: map['main']['temp'],
      latitude: map['coord']['lat'],
      longitude: map['coord']['lon'],
      countryName: map['sys']['country'],
      cityName: map['name'],
      condition: map['cod'],
      windSpeed: map['wind']['speed'],
    );
  }

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Weather(temperature: $temperature, latitude: $latitude, longitude: $longitude, countryName: $countryName, cityName: $cityName,condition:$condition,windSpeed:$windSpeed)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Weather &&
        o.temperature == temperature &&
        o.latitude == latitude &&
        o.longitude == longitude &&
        o.countryName == countryName &&
        o.cityName == cityName &&
        o.windSpeed == windSpeed &&
        o.condition == condition;
  }

  @override
  int get hashCode {
    return temperature.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        countryName.hashCode ^
        cityName.hashCode ^
        windSpeed.hashCode ^
        condition.hashCode;
  }
}
