import 'package:flutter_tdd_clean_architecture/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.country,
    required super.main,
    required super.description,
    required super.iconCode,
    required super.temperature,
    required super.pressure,
    required super.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      country: json['sys']['country'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      temperature: json['main']['temp'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weather': [
        {
          'main': main,
          'description': description,
          'icon': iconCode,
        }
      ],
      'main': {
        'temp': temperature,
        'pressure': pressure,
        'humidity': humidity,
      },
      'sys': {
        'country': country,
      },
      'name': cityName,
    };
  }

  WeatherEntity toEntity() => WeatherEntity(
        cityName: cityName,
        country: country,
        main: main,
        description: description,
        iconCode: iconCode,
        temperature: temperature,
        pressure: pressure,
        humidity: humidity,
      );
}
