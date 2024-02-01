import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/params/get_weather_params.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';
import 'package:weather_app/features/weather/domain/usecases/weather/get_weather_by_location.dart';

/// Provides state and functions for the weather data
class WeatherProvider extends ChangeNotifier {
  final GetWeatherByLocationUseCase _getWeatherByLocationUseCase;

  /// holds the weather data
  WeatherForecastEntity? _weather;

  /// saves the last failure
  Failure? _failure;

  /// boolean if it loads
  bool _loading = false;

  WeatherProvider(this._getWeatherByLocationUseCase);

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

    final weatherOrFailure = await _getWeatherByLocationUseCase.call(
      params: GetWeatherParams(
        appid: dotenv.get("OPEN_WEATHER_APP_ID"),
        units: "metric",
      ),
    );

    weatherOrFailure.handle(
      onSuccess: (weather) => _weather = weather,
      onError: (failure) => _failure = failure,
    );

    _loading = false;
    notifyListeners();
  }
}
