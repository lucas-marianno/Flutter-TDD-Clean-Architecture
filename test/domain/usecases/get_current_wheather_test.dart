import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/domain/entities/wheather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tdd_clean_architecture/domain/usecases/get_current_wheather.dart';
import 'package:mockito/mockito.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  // ensure that the repository is actually called
  // ensure that the data passes unchanged through the usecase
  late GetCurrentWheatherUseCase getCurrentWheatherUseCase;
  late MockWheatherRepository mockWheatherRepository;

  const testWheatherDetail = WheatherEntity(
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
    mockWheatherRepository = MockWheatherRepository();
    getCurrentWheatherUseCase =
        GetCurrentWheatherUseCase(mockWheatherRepository);
  });

  // AAA Pattern
  test('should get current wheather detail from repository', () async {
    // arrange
    when(mockWheatherRepository.getCurrentWheather(testCityName))
        .thenAnswer((_) async => const Right(testWheatherDetail));
    // act

    final response = await getCurrentWheatherUseCase.execute(testCityName);
    // assert

    expect(response, const Right(testWheatherDetail));
  });
}
