import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/core/error/failure.dart';
import 'package:flutter_tdd_clean_architecture/domain/entities/weather.dart';
import 'package:flutter_tdd_clean_architecture/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  GetCurrentWeatherUseCase(this.weatherRepository);

  final WeatherRepository weatherRepository;

  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
