import 'package:weather_icons/weather_icons.dart';

class WeatherCondition {
//get mesage
//get icon

  static getMessage(int condition) {
    if (condition <= 300) {
      return 'ThunderStorm';
    } else if (condition <= 500) {
      return 'Rain';
    } else if (condition <= 600) {
      return 'Snow';
    } else if (condition < 800) {
      return 'Atmosphere';
    } else if (condition == 800) {
      return 'Clear';
    } else if (condition >= 801) {
      return 'Cloudy';
    }
  }

  static getIcon(int condition) {
    if (condition <= 300) {
      return WeatherIcons.thunderstorm;
    } else if (condition <= 500) {
      return WeatherIcons.rain;
    } else if (condition <= 600) {
      return WeatherIcons.snow;
    } else if (condition < 800) {
      return WeatherIcons.day_cloudy;
    } else if (condition == 800) {
      return WeatherIcons.cloud_refresh;
    } else if (condition >= 801) {
      return WeatherIcons.cloud;
    }
  }
}