import 'package:flutter_tdd_clean_architecture/config.dart';

class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/';
  static const String apiKey = OPEN_WEATHER_API_KEY;

  static String currentWeatherByName(String cityName) =>
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';

  static String weatherIcon(String iconCode) =>
      'https://openweathermap.org/img/wn/$iconCode@2x.png';
}
