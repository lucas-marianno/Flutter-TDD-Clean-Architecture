part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherEmpty extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final WeatherEntity weatherResult;
  const WeatherLoaded(this.weatherResult);

  @override
  List<Object> get props => [weatherResult];
}

final class WeatherLoadFailure extends WeatherState {
  final String failure;

  const WeatherLoadFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
