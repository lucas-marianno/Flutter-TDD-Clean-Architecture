part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

final class CityChanged extends WeatherEvent {
  final String cityName;
  const CityChanged(this.cityName);

  @override
  List<Object> get props => [cityName];
}
