import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';

abstract class RemoteWeatherState extends Equatable {
  final WeatherForecastEntity? weather;
  final DioException? error;

  const RemoteWeatherState({this.error, this.weather});

  @override
  List<Object?> get props => [weather, error];
}

class RemoteWeatherLoading extends RemoteWeatherState {
  const RemoteWeatherLoading();
}

class RemoteWeatherDone extends RemoteWeatherState {
  const RemoteWeatherDone(WeatherForecastEntity weather)
      : super(weather: weather);
}

class RemoteWeatherError extends RemoteWeatherState {
  const RemoteWeatherError(DioException error) : super(error: error);
}
