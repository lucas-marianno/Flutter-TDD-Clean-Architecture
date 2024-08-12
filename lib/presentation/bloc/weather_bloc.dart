import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tdd_clean_architecture/domain/entities/weather.dart';
import 'package:flutter_tdd_clean_architecture/domain/usecases/get_current_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<CityChanged>(_onCityChanged);
  }
  _onCityChanged(CityChanged event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    final result = await _getCurrentWeatherUseCase.execute(event.cityName);
  }
}
