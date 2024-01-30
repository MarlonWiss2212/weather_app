import 'package:flutter/material.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/params/params.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/weather/get_weather.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository weatherRepository;
  WeatherForecastEntity? _weather;
  Failure? _failure;
  bool _loading = false;

  WeatherProvider({
    required this.weatherRepository,
  });

  Failure? get failure {
    return _failure;
  }

  bool get loading {
    return _loading;
  }

  WeatherForecastEntity? get weather {
    return _weather;
  }

  /// Represents the function responsible for retrieving weather data.
  Future<void> getWeather({required GetWeatherParams params}) async {
    _loading = true;
    notifyListeners();

    final weatherOrFailure =
        await GetWeatherUseCase(weatherRepository: weatherRepository).call(
      params: params,
    );

    if (weatherOrFailure is DataSuccess && weatherOrFailure.data != null) {
      _weather = weather;
    } else if (weatherOrFailure is DataFailed &&
        weatherOrFailure.error != null) {
      _failure = weatherOrFailure.error;
    }
    _loading = false;
    notifyListeners();
  }
}
