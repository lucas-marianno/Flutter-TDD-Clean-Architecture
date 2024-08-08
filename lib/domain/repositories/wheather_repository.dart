import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/core/error/failure.dart';
import 'package:flutter_tdd_clean_architecture/domain/entities/wheather.dart';

abstract class WheatherRepository {
  Future<Either<Failure, WheatherEntity>> getCurrentWheather(String cityName);
}
