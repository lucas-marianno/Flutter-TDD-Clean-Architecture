import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/core/error/failure.dart';
import 'package:flutter_tdd_clean_architecture/domain/entities/wheather.dart';
import 'package:flutter_tdd_clean_architecture/domain/repositories/wheather_repository.dart';

class GetCurrentWheatherUseCase {
  GetCurrentWheatherUseCase(this.wheatherRepository);

  final WheatherRepository wheatherRepository;

  Future<Either<Failure, WheatherEntity>> execute(String cityName) {
    return wheatherRepository.getCurrentWheather(cityName);
  }
}
