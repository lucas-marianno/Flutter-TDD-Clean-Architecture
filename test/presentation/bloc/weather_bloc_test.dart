import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/core/error/failure.dart';
import 'package:flutter_tdd_clean_architecture/domain/entities/weather.dart';
import 'package:flutter_tdd_clean_architecture/domain/usecases/get_current_weather.dart';
import 'package:flutter_tdd_clean_architecture/presentation/bloc/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
    weatherBloc = WeatherBloc(getCurrentWeatherUseCase);
  });

  const testWeatherEntity = WeatherEntity(
    cityName: 'São Paulo',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 295.42,
    pressure: 1014,
    humidity: 57,
  );

  const testCityName = 'Sao Paulo';

  group('WeatherBloc test', () {
    test('initial state should be empty', () {
      expect(weatherBloc.state, WeatherEmpty());
    });

    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoaded] when data get is sucessful',
      build: () {
        when(
          getCurrentWeatherUseCase.execute(testCityName),
        ).thenAnswer(
          (_) async => const Right(testWeatherEntity),
        );

        return weatherBloc;
      },
      act: (bloc) => bloc.add(const CityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        const WeatherLoaded(testWeatherEntity),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoadFailure] when data get fails',
      build: () {
        when(
          getCurrentWeatherUseCase.execute(testCityName),
        ).thenAnswer(
          (_) async => const Left(ServerFailure('Server failure')),
        );

        return weatherBloc;
      },
      act: (bloc) => bloc.add(const CityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        const WeatherLoadFailure('Server failure'),
      ],
    );
  });
}
