import 'package:flutter/material.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/params/get_weather_params.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';
import 'package:weather_app/features/weather/domain/usecases/weather/get_weather_by_location.dart';

/// Provides state and functions for the weather data
class WeatherProvider extends ChangeNotifier {
  final GetWeatherByLocationUseCase getWeatherByLocationUseCase;

  WeatherForecastEntity? _weather;
  Failure? _failure;
  bool _loading = false;

  WeatherProvider({
    required this.getWeatherByLocationUseCase,
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
  Future<void> getWeather() async {
    _loading = true;
    notifyListeners();

    final weatherOrFailure = await getWeatherByLocationUseCase.call(
      params: const GetWeatherParams(appid: "appid"),
    );

    weatherOrFailure.handle(
      onSuccess: (weather) => _weather = weather,
      onError: (failure) => _failure = failure,
    );

    _loading = false;
    notifyListeners();
  }
}
