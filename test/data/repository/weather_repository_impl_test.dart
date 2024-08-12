import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/core/error/exception.dart';
import 'package:flutter_tdd_clean_architecture/core/error/failure.dart';
import 'package:flutter_tdd_clean_architecture/data/models/weather_model.dart';
import 'package:flutter_tdd_clean_architecture/data/repositories/weather_repository_impl.dart';
import 'package:flutter_tdd_clean_architecture/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;
  const testCityName = 'Sao Paulo';
  const testWeatherModel = WeatherModel(
    cityName: 'São Paulo',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 295.42,
    pressure: 1014,
    humidity: 57,
  );
  const testWeatherEntity = WeatherEntity(
    cityName: 'São Paulo',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 295.42,
    pressure: 1014,
    humidity: 57,
  );
  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
      weatherRemoteDataSource: mockWeatherRemoteDataSource,
    );
  });

  group('repository test', () {
    test(
      'should return current weather when a call to data source is sucessful',
      () async {
        // arrange
        when(
          mockWeatherRemoteDataSource.getCurrentWeather(testCityName),
        ).thenAnswer(
          (_) async => testWeatherModel,
        );

        // act
        final response = await weatherRepositoryImpl.getCurrentWeather(
          testCityName,
        );

        // assert
        expect(response, equals(const Right(testWeatherEntity)));
      },
    );

    test(
      'should return ServerFailure when a call to data source is unsucessful',
      () async {
        // arrange
        when(
          mockWeatherRemoteDataSource.getCurrentWeather(testCityName),
        ).thenThrow(
          ServerException(),
        );

        // act
        final response = await weatherRepositoryImpl.getCurrentWeather(
          testCityName,
        );

        // assert
        expect(
          response,
          equals(const Left(ServerFailure('An error has ocurred'))),
        );
      },
    );
    test(
      'should return ConnectionFailure when unable to connect',
      () async {
        // arrange
        when(
          mockWeatherRemoteDataSource.getCurrentWeather(testCityName),
        ).thenThrow(
          const SocketException(''),
        );

        // act
        final response = await weatherRepositoryImpl.getCurrentWeather(
          testCityName,
        );

        // assert
        expect(
          response,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });
}
