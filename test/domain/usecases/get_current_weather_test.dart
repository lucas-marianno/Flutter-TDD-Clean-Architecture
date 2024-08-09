import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tdd_clean_architecture/domain/usecases/get_current_weather.dart';
import 'package:mockito/mockito.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  // ensure that the repository is actually called
  // ensure that the data passes unchanged through the usecase
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  const testWeatherDetail = WeatherEntity(
    cityName: 'New York',
    main: 'clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.5,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  // AAA Pattern
  test('should get current Weather detail from repository', () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));
    // act

    final response = await getCurrentWeatherUseCase.execute(testCityName);
    // assert

    expect(response, const Right(testWeatherDetail));
  });
}
