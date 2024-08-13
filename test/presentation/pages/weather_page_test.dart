import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture/domain/entities/weather.dart';
import 'package:flutter_tdd_clean_architecture/presentation/bloc/weather_bloc.dart';
import 'package:flutter_tdd_clean_architecture/presentation/pages/weather_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(home: body),
    );
  }

  const testWeatherEntity = WeatherEntity(
    cityName: 'São Paulo',
    country: 'BR',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 295.42,
    pressure: 1014,
    humidity: 57,
  );

  testWidgets('text field should trigger state to change from empty to loading',
      (widgetTester) async {
    // arrange
    when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

    // act
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    // assert
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    // act
    await widgetTester.enterText(textField, 'São Paulo');
    await widgetTester.pump();

    // assert
    expect(find.text('São Paulo'), findsOneWidget);
  });

  testWidgets('should show progress indicator when state is loading',
      (widgetTester) async {
    // arrange
    when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

    // act
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    // assert
    final progressIndicator = find.byType(CircularProgressIndicator);
    expect(progressIndicator, findsOneWidget);
  });

  testWidgets('should show data when state is Loaded', (widgetTester) async {
    // arrange
    when(
      () => mockWeatherBloc.state,
    ).thenReturn(const WeatherLoaded(testWeatherEntity));

    // act
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    // assert
    final weatherDataWidget = find.byKey(const Key('weather_data'));
    expect(weatherDataWidget, findsOneWidget);
  });
}
