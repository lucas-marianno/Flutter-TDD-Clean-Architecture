import 'dart:convert';
import 'package:flutter_tdd_clean_architecture/core/constants/constants.dart';
import 'package:flutter_tdd_clean_architecture/core/error/exception.dart';
import 'package:flutter_tdd_clean_architecture/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
