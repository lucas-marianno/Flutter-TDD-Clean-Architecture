import 'package:flutter_tdd_clean_architecture/core/constants/constants.dart';
import 'package:flutter_tdd_clean_architecture/core/error/exception.dart';
import 'package:flutter_tdd_clean_architecture/data/data_source/remote_data_source.dart';
import 'package:flutter_tdd_clean_architecture/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helper/json_reader.dart';
import '../../helper/test_helper.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;
  const testCityName = 'Sao Paulo';

  setUp(() {
    mockHttpClient = MockHttpClient();

    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get current weather', () {
    test('should return a valid model when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(
        Uri.parse(Urls.currentWeatherByName(testCityName)),
      )).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_weather_response.json'),
          200,
        ),
      );

      // act
      final response = await weatherRemoteDataSourceImpl.getCurrentWeather(
        testCityName,
      );

      // assert
      expect(response, isA<WeatherModel>());
    });

    test('should throw a ServerException when response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(
        Uri.parse(Urls.currentWeatherByName(testCityName)),
      )).thenAnswer(
        (_) async => http.Response(
          'Not found',
          404,
        ),
      );

      // act
      final response = weatherRemoteDataSourceImpl.getCurrentWeather(
        testCityName,
      );
      // assert
      expect(response, throwsA(isA<ServerException>()));
    });
  });
}
