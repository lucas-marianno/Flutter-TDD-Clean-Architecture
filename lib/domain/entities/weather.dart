import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  const WeatherEntity({
    required this.cityName,
    required this.country,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.pressure,
    required this.humidity,
  });

  final String cityName;
  final String country;
  final String main;
  final String description;
  final String iconCode;
  final double temperature;
  final int pressure;
  final int humidity;

  @override
  List<Object?> get props => [
        cityName,
        country,
        main,
        description,
        iconCode,
        temperature,
        pressure,
        humidity,
      ];
}
