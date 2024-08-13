// is the model that we've created equal to the entities in domain layer?
// does the fromJson return a valid model?
// does the toJson return a proper json map?

import 'dart:convert';

import 'package:flutter_tdd_clean_architecture/data/models/weather_model.dart';
import 'package:flutter_tdd_clean_architecture/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'São Paulo',
    country: 'BR',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 295.42,
    pressure: 1014,
    humidity: 57,
  );

  group('weather model test', () {
    test('should be a subclass from WheaterEntity', () {
      expect(testWeatherModel, isA<WeatherEntity>());
    });

    test('.fromJson should return a valid WeatherModel', () {
      // arrange
      final Map<String, dynamic> mockWeatherAPIResponse = json.decode(
        readJson('dummy_weather_response.json'),
      );

      // act
      final weatherModel = WeatherModel.fromJson(mockWeatherAPIResponse);

      // assert
      expect(weatherModel, equals(testWeatherModel));
    });

    test('.toJson should return a valid jsonMap', () {
      // arrange
      const expectedJson = {
        'weather': [
          {
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01n',
          }
        ],
        'main': {
          'temp': 295.42,
          'pressure': 1014,
          'humidity': 57,
        },
        'sys': {
          'country': 'BR',
        },
        'name': 'São Paulo',
      };

      // act
      final jsonMap = testWeatherModel.toJson();

      //assert
      expect(jsonMap, expectedJson);
    });

    test('.toEntity should return a valid WeatherEntity', () {
      // arrange
      const testWeatherEntity = WeatherEntity(
        cityName: 'São Paulo',
        country: 'BR',
        main: 'Clear',
        description: 'clear sky',
        iconCode: '01n',
        temperature: 295.42,
        pressure: 1014,
        humidity: 57,
      );

      // act
      final weatherEntity = testWeatherModel.toEntity();

      // assert
      expect(weatherEntity, equals(testWeatherEntity));
    });
  });
}
